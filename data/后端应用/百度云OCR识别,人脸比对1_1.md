```java
package com.ecovacs.store.util;

import cn.jiguang.common.utils.StringUtils;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.ecovacs.common.pojo.http.HttpResult;
import com.ecovacs.common.util.http.HttpClientUtils;
import com.ecovacs.common.util.sign.Base64Util;
import com.ecovacs.core.ServiceManager;
import com.ecovacs.core.exception.EcovacsValidateException;
import com.ecovacs.store.cache.ConfigCacheManager;
import com.ecovacs.store.constants.ConfigKeyConstant;
import com.ecovacs.store.service.config.ConfigService;
import lombok.Data;
import okhttp3.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;
import sun.misc.BASE64Encoder;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import javax.imageio.ImageIO;

/**
 * @date: 2023/5/12 16:20
 */
public class BaiDuosUtil {

    private static Logger logger= LoggerFactory.getLogger(BaiDuosUtil.class);
    private static BaiDuosConfig baiDuosConfig = null;

    static final OkHttpClient HTTP_CLIENT = new OkHttpClient().newBuilder().build();

    /**
     * 百度云人脸比对1:1
     * @param file
     * @param url
     * @return
     */
    public static boolean compareFace(MultipartFile file, String url) {
        try {
            BaiDuosConfig config = getConfig();
            String token = getFaceToken();
            String newBase = Base64Util.encode(file.getBytes());
            JSONObject newMap = new JSONObject();
            newMap.put("image", newBase);
            newMap.put("image_type", "BASE64");
            newMap.put("quality_control", "NORMAL");//图片质量
            newMap.put("liveness_control", "NORMAL");//活体检测
            String oldBase = imgUrl2Base64(url);
            JSONObject oldMap = new JSONObject();
            oldMap.put("image", oldBase);
            oldMap.put("image_type", "BASE64");
            oldMap.put("quality_control", "NORMAL");//图片质量
            oldMap.put("liveness_control", "NORMAL");//活体检测
            JSONArray jsonArray = new JSONArray();
            jsonArray.add(newMap);
            jsonArray.add(oldMap);
            String apiUrl = config.faceApiHost + "?access_token=" + token;
            HttpResult httpResult = HttpClientUtils.doPostJson(apiUrl, jsonArray.toJSONString());
            if (httpResult.isSuccess()) {
                JSONObject jsonObject = JSONObject.parseObject(httpResult.getBody(), JSONObject.class);
                JSONObject result = jsonObject.getJSONObject("result");
                int score = result.getIntValue("score");
                if (score >= config.facePassScore) {
                    return true;
                }
            }
        } catch (Exception e) {
            logger.info("调用百度云人脸比对失败, " + e.getMessage());
            e.printStackTrace();
        }

        return false;
    }

    /**
     * 百度云OCR图片识别_办公文档识别
     * @param file 参数二选一, 默认file
     * @param url
     * @return
     */
    public static String ocrOffice(MultipartFile file, String url,byte[] bytes,String fileFormat)  {
        BaiDuosConfig config = getConfig();
        StringBuilder result = new StringBuilder();
        if (file == null && StringUtils.isEmpty(url) && bytes == null) {
            throw new EcovacsValidateException("文件为空");
        }
        try {
            String imgStr = bytes == null ? imgUrl2Base64(url) : Base64Util.encode(bytes);
            String encode = URLEncoder.encode(generateThumbnail(imgStr,4, fileFormat));
            MediaType mediaType = MediaType.parse("application/x-www-form-urlencoded");
            RequestBody body = RequestBody.create(mediaType, "image="+encode+"&detect_direction=true");
            Request request = new Request.Builder()
                    .url(config.ocrApiHost+"?access_token=" + getOcrToken())
                    .method("POST", body)
                    .addHeader("Content-Type", "application/x-www-form-urlencoded")
                    .addHeader("Accept", "application/json")
                    .build();
            Response response = HTTP_CLIENT.newCall(request).execute();
            if (response.isSuccessful()){
                JSONObject object = JSONObject.parseObject(response.body().string());
                logger.info("调用百度云OCR图片识别结果: " + object.toJSONString());
                if (object!=null){
                    List<JSONObject> jsonArray = JSONObject.parseArray(object.getString("words_result"), JSONObject.class);
                    for (JSONObject o : jsonArray) {
                        result.append(o.get("words"));
                    }
                }
            }

        } catch (Exception e) {
            logger.info("调用百度云OCR图片识别失败, " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException(e);
        }
        logger.info(String.format("调用百度云OCR图片识别结果, url: %s, result: %s ",url,result));
        return result.toString();
    }

    /**
     * 印章识别
     * @param bytes
     * @return
     */
    public static String ocrSeal(byte[] bytes, String fileFormat)  {
        BaiDuosConfig config = getConfig();
        StringBuilder result = new StringBuilder();
        if (bytes == null) {
            throw new EcovacsValidateException("文件为空");
        }
        try {
            String imgStr = bytes == null ? "": Base64Util.encode(bytes);
            String encode = URLEncoder.encode(generateThumbnail(imgStr,4, fileFormat));
            MediaType mediaType = MediaType.parse("application/x-www-form-urlencoded");
            RequestBody body = RequestBody.create(mediaType, "image="+encode);
            Request request = new Request.Builder()
                    .url(config.ocrSealApi+"?access_token=" + getOcrToken())
                    .method("POST", body)
                    .addHeader("Content-Type", "application/x-www-form-urlencoded")
                    .addHeader("Accept", "application/json")
                    .build();
            Response response = HTTP_CLIENT.newCall(request).execute();
            if (response.isSuccessful()){
                JSONObject object = JSONObject.parseObject(response.body().string());
                JSONArray resultArray = object.getJSONArray("result");
                logger.info("调用百度云OCR印章识别结果: " + object.toJSONString());
                if (resultArray != null && resultArray.size() > 0) {
                    JSONObject firstElement = resultArray.getJSONObject(0);
                    String words = firstElement.getJSONObject("major").getString("words");
                    result.append(words);
                }
            }

        } catch (Exception e) {
            logger.info("调用百度云OCR印章识别失败, " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException(e);
        }
        logger.info(String.format("调用百度云OCR印章识别结果, result: %s ",result));
        return result.toString();
    }

    /**
     * 获取缩略图  百度云ocr识别最大支持4MB大小的图片
     * @param base64Image
     * @param size
     * @return
     */
    public static String generateThumbnail(String base64Image, int size, String fileFormat) {
        // 解码 Base64 编码的图片
        byte[] imageBytes = Base64Util.decode(base64Image);

        // 生成缩略图并返回缩略图的 Base64 编码
        try (ByteArrayOutputStream outputStream = new ByteArrayOutputStream()) {
            BufferedImage originalImage = ImageIO.read(new ByteArrayInputStream(imageBytes));
            int originalWidth = originalImage.getWidth();
            int originalHeight = originalImage.getHeight();

            // 如果图片大小已经小于 size MB，则返回原始的 Base64 编码
            if (imageBytes.length < size * 1024 * 1024 && originalWidth < 4096 && originalHeight < 4096) {
                return base64Image;
            }

            int scale = 2;
            BufferedImage outputImage = originalImage;

            while (imageBytes.length >= size * 1024 * 1024||outputImage.getWidth()>4096||outputImage.getHeight()>4096) {
                int newWidth = originalWidth / scale;
                int newHeight = originalHeight / scale;
                BufferedImage newImage = new BufferedImage(newWidth, newHeight, BufferedImage.TYPE_INT_RGB);
                Graphics2D g2d = newImage.createGraphics();
                g2d.drawImage(outputImage, 0, 0, newWidth, newHeight, null);
                g2d.dispose();
                outputImage = newImage;
                try (ByteArrayOutputStream tempStream = new ByteArrayOutputStream()) {
                    ImageIO.write(outputImage, fileFormat, tempStream);
                    imageBytes = tempStream.toByteArray();
                }
                scale *= 2;
            }
            ImageIO.write(outputImage, fileFormat, outputStream);
            byte[] thumbnailBytes = outputStream.toByteArray();
            return Base64Util.encode(thumbnailBytes);
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }

    private static String getToken(String authHost, String apiKey, String secretKey, String constant) {
        String token = null;
        //访问百度云官网获取token
        String getAccessTokenUrl = authHost
                + "grant_type=client_credentials"
                + "&client_id=" + apiKey
                + "&client_secret=" + secretKey;
        HttpResult httpResult = HttpClientUtils.doGet(getAccessTokenUrl);
        if (httpResult.isSuccess()) {
            JSONObject jsonObject = JSONObject.parseObject(httpResult.getBody(), JSONObject.class);
            token = jsonObject.getString("access_token");
            //更新缓存
            ConfigService configService = ServiceManager.getService(ConfigService.class);
            String configValue = token + "," + System.currentTimeMillis();
            configService.updateValue4key(constant, configValue);
        }
        return token;
    }

    private static String getFaceToken() {
        String token = null;
        //百度云官网获取的token有30天的有效期,需要定期更换
        String configValue = ConfigCacheManager.getConfigValue(ConfigKeyConstant.SP_BAIDU_FACE_TOKEN_CONFIG);
        if (StringUtils.isEmpty(configValue)) {
            return getToken(baiDuosConfig.tokenAuthHost, baiDuosConfig.faceApiKey, baiDuosConfig.faceSecretKey, ConfigKeyConstant.SP_BAIDU_FACE_TOKEN_CONFIG);
        }
        String[] cons = configValue.split(",");
        long days = (System.currentTimeMillis() - Long.valueOf(cons[1])) / 86400000;
        if (days < 29) {
            token = cons[0];
        } else {
            token = getToken(baiDuosConfig.tokenAuthHost, baiDuosConfig.faceApiKey, baiDuosConfig.faceSecretKey, ConfigKeyConstant.SP_BAIDU_FACE_TOKEN_CONFIG);

        }
        return token;
    }

    private static String getOcrToken() {
        String token = null;
        //百度云官网获取的token有30天的有效期,需要定期更换
        String configValue = ConfigCacheManager.getConfigValue(ConfigKeyConstant.SP_BAIDU_OCR_TOKEN_CONFIG);
        if (StringUtils.isEmpty(configValue)) {
            return getToken(baiDuosConfig.tokenAuthHost, baiDuosConfig.ocrApiKey, baiDuosConfig.ocrSecretKey, ConfigKeyConstant.SP_BAIDU_OCR_TOKEN_CONFIG);
        }
        String[] cons = configValue.split(",");
        long days = (System.currentTimeMillis() - Long.valueOf(cons[1])) / 86400000;
        if (days < 29) {
            token = cons[0];
        } else {
            token = getToken(baiDuosConfig.tokenAuthHost, baiDuosConfig.ocrApiKey, baiDuosConfig.ocrSecretKey, ConfigKeyConstant.SP_BAIDU_OCR_TOKEN_CONFIG);
        }
        return token;
    }

    private static String imgUrl2Base64(String imgUrl) {
        URL url = null;
        InputStream is = null;
        ByteArrayOutputStream outStream = null;
        HttpURLConnection httpUrl = null;

        try {
            url = new URL(imgUrl);
            httpUrl = (HttpURLConnection) url.openConnection();
            httpUrl.connect();
            httpUrl.getInputStream();

            is = httpUrl.getInputStream();
            outStream = new ByteArrayOutputStream();

            //创建一个Buffer字符串
            byte[] buffer = new byte[1024];
            //每次读取的字符串长度，如果为-1，代表全部读取完毕
            int len = 0;
            //使用输入流从buffer里把数据读取出来
            while ((len = is.read(buffer)) != -1) {
                //用输出流往buffer里写入数据，中间参数代表从哪个位置开始读，len代表读取的长度
                outStream.write(buffer, 0, len);
            }

            // 对字节数组Base64编码
            return encode(outStream.toByteArray());
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (is != null) {
                    is.close();
                }
                if (outStream != null) {
                    outStream.close();
                }
                if (httpUrl != null) {
                    httpUrl.disconnect();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    private static BufferedImage resizeImage(BufferedImage originalImage, int newWidth, int newHeight) {
        BufferedImage resizedImage = new BufferedImage(newWidth, newHeight, originalImage.getType());
        // 使用 Graphics2D 进行图片缩放
        java.awt.Graphics2D g = resizedImage.createGraphics();
        g.drawImage(originalImage, 0, 0, newWidth, newHeight, null);
        g.dispose();
        return resizedImage;
    }

    private static void compression(byte[] imageBytes) {
        String base64Image = "Your Base64 Image String"; // 替换为你的 Base64 图片字符串
        String outputPath = "path/to/output/image.jpg"; // 替换为你的输出图片路径

        try {
            // 将 Base64 字符串解码为字节数组

            // 将字节数组转换为 BufferedImage
            ByteArrayInputStream bis = new ByteArrayInputStream(imageBytes);
            BufferedImage originalImage = ImageIO.read(bis);

            // 获取原始分辨率
            int originalWidth = originalImage.getWidth();
            int originalHeight = originalImage.getHeight();
            System.out.println("原始分辨率：" + originalWidth + "x" + originalHeight);

            // 压缩图片
            int newWidth = 4096; // 新的宽度
            int newHeight = 4096; // 新的高度
            BufferedImage resizedImage = resizeImage(originalImage, newWidth, newHeight);

            // 获取压缩后的分辨率
            int resizedWidth = resizedImage.getWidth();
            int resizedHeight = resizedImage.getHeight();
            System.out.println("压缩后的分辨率：" + resizedWidth + "x" + resizedHeight);

            // 将压缩后的图片保存到文件
            File outputImage = new File(outputPath);
            ImageIO.write(resizedImage, "jpg", outputImage);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static String encode(byte[] img) {
        BASE64Encoder decoder = new BASE64Encoder();
        String encode = decoder.encode(img);
        String reg = "[\n-\r]";
        Pattern p = Pattern.compile(reg);
        Matcher m = p.matcher(encode);
        return m.replaceAll("");
    }

    private static BaiDuosConfig getConfig() {
        if (baiDuosConfig == null) {
            String configValue = ConfigCacheManager.getConfigValue(ConfigKeyConstant.SP_BAIDU_OS_CONFIG);
            baiDuosConfig = JSONObject.parseObject(configValue, BaiDuosConfig.class);
        }
        return baiDuosConfig;
    }


    @Data
    static class BaiDuosConfig{
        private String tokenAuthHost;//百度云token url

        private String faceApiHost;//百度云人脸url
        private String faceApiKey;//百度云人脸key
        private String faceSecretKey;//百度云人脸secret
        private int facePassScore;//百度云人脸合格分

        private String ocrApiHost;//百度云ocr url
        private String ocrApiKey;//百度云ocr key
        private String ocrSecretKey;//百度云ocr secret

        private String ocrSealApi;//百度云印章识别url
    }
}

```

