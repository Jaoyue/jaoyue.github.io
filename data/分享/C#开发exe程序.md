> HTML 页面: [[page/wiki/data/分享/C#开发exe程序.html|打开 HTML 页面]]

## 1.打开记事本,复制代码(简易计算器)

```csharp
// 文件名：Calculator.cs
// 引入图形界面和基础库
using System;
using System.Windows.Forms;
using System.Drawing;

// 计算器主窗口类
public class CalculatorForm : Form
{
    // 声明界面控件：显示输入和结果的文本框、数字按钮、运算符按钮
    private TextBox txtDisplay;
    // 存储运算的中间值和运算符
    private double firstNumber = 0;
    private string operation = "";
    private bool isNewInput = true;

    // 窗口构造函数，初始化界面和控件
    public CalculatorForm()
    {
        // 窗口基本设置
        this.Text = "简易计算器"; // 窗口标题
        this.Size = new Size(300, 400); // 窗口大小（宽×高）
        this.StartPosition = FormStartPosition.CenterScreen; // 窗口居中
        this.FormBorderStyle = FormBorderStyle.FixedSingle; // 固定窗口大小，不可拉伸
        this.MaximizeBox = false; // 禁用最大化按钮

        // 初始化显示文本框
        txtDisplay = new TextBox();
        txtDisplay.Location = new Point(20, 20); // 位置（左20，上20）
        txtDisplay.Size = new Size(240, 35); // 大小
        txtDisplay.Font = new Font("微软雅黑", 14); // 字体和字号
        txtDisplay.TextAlign = HorizontalAlignment.Right; // 文字右对齐（符合计算器习惯）
        txtDisplay.ReadOnly = false; // 允许手动输入，也可设为true仅通过按钮输入
        txtDisplay.Text = "0"; // 初始显示0
        this.Controls.Add(txtDisplay);

        // 初始化按钮：按行创建，分别是数字、运算符、功能按钮
        int buttonTop = 70; // 第一行按钮的顶部位置
        int buttonWidth = 50; // 按钮宽度
        int buttonHeight = 40; // 按钮高度
        int gap = 10; // 按钮之间的间距

        // 第一行：7、8、9、÷
        AddButton("7", new Point(20, buttonTop), buttonWidth, buttonHeight, NumberButton_Click);
        AddButton("8", new Point(20 + buttonWidth + gap, buttonTop), buttonWidth, buttonHeight, NumberButton_Click);
        AddButton("9", new Point(20 + 2*(buttonWidth + gap), buttonTop), buttonWidth, buttonHeight, NumberButton_Click);
        AddButton("÷", new Point(20 + 3*(buttonWidth + gap), buttonTop), buttonWidth, buttonHeight, OperationButton_Click);

        // 第二行：4、5、6、×
        buttonTop += buttonHeight + gap;
        AddButton("4", new Point(20, buttonTop), buttonWidth, buttonHeight, NumberButton_Click);
        AddButton("5", new Point(20 + buttonWidth + gap, buttonTop), buttonWidth, buttonHeight, NumberButton_Click);
        AddButton("6", new Point(20 + 2*(buttonWidth + gap), buttonTop), buttonWidth, buttonHeight, NumberButton_Click);
        AddButton("×", new Point(20 + 3*(buttonWidth + gap), buttonTop), buttonWidth, buttonHeight, OperationButton_Click);

        // 第三行：1、2、3、-
        buttonTop += buttonHeight + gap;
        AddButton("1", new Point(20, buttonTop), buttonWidth, buttonHeight, NumberButton_Click);
        AddButton("2", new Point(20 + buttonWidth + gap, buttonTop), buttonWidth, buttonHeight, NumberButton_Click);
        AddButton("3", new Point(20 + 2*(buttonWidth + gap), buttonTop), buttonWidth, buttonHeight, NumberButton_Click);
        AddButton("-", new Point(20 + 3*(buttonWidth + gap), buttonTop), buttonWidth, buttonHeight, OperationButton_Click);

        // 第四行：0、.、=、+
        buttonTop += buttonHeight + gap;
        AddButton("0", new Point(20, buttonTop), buttonWidth, buttonHeight, NumberButton_Click);
        AddButton(".", new Point(20 + buttonWidth + gap, buttonTop), buttonWidth, buttonHeight, NumberButton_Click);
        AddButton("=", new Point(20 + 2*(buttonWidth + gap), buttonTop), buttonWidth, buttonHeight, EqualsButton_Click);
        AddButton("+", new Point(20 + 3*(buttonWidth + gap), buttonTop), buttonWidth, buttonHeight, OperationButton_Click);

        // 第五行：C（清空）、←（退格）
        buttonTop += buttonHeight + gap;
        AddButton("C", new Point(20, buttonTop), buttonWidth * 2 + gap, buttonHeight, ClearButton_Click); // 宽度加倍
        AddButton("←", new Point(20 + buttonWidth*2 + 2*gap, buttonTop), buttonWidth * 2 + gap, buttonHeight, BackspaceButton_Click); // 宽度加倍
    }

    // 封装按钮创建方法，减少重复代码
    private void AddButton(string text, Point location, int width, int height, EventHandler clickEvent)
    {
        Button btn = new Button();
        btn.Text = text;
        btn.Location = location;
        btn.Size = new Size(width, height);
        btn.Font = new Font("微软雅黑", 12);
        btn.Click += clickEvent; // 绑定点击事件
        this.Controls.Add(btn);
    }

    // 数字和小数点按钮点击事件
    private void NumberButton_Click(object sender, EventArgs e)
    {
        Button btn = sender as Button;
        string buttonText = btn.Text;

        // 如果是新输入（比如刚按完运算符、等号），清空显示框，显示新数字
        if (isNewInput)
        {
            txtDisplay.Text = "0";
            isNewInput = false;
        }

        // 处理小数点：只能有一个小数点
        if (buttonText == "." && txtDisplay.Text.Contains("."))
        {
            return; // 已有小数点，不处理
        }

        // 处理初始0：如果显示0，点击数字后替换成该数字，否则追加
        if (txtDisplay.Text == "0" && buttonText != ".")
        {
            txtDisplay.Text = buttonText;
        }
        else
        {
            txtDisplay.Text += buttonText;
        }
    }

    // 运算符按钮点击事件（+、-、×、÷）
    private void OperationButton_Click(object sender, EventArgs e)
    {
        Button btn = sender as Button;
        // 提前声明临时变量，兼容C# 5
        double tempNumber;
        // 记录第一个运算数和运算符
        if (double.TryParse(txtDisplay.Text, out tempNumber))
        {
            firstNumber = tempNumber;
            operation = btn.Text;
            isNewInput = true; // 标记为新输入，后续输入的是第二个数
        }
    }

    // 等号按钮点击事件：执行运算
    private void EqualsButton_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(operation) || isNewInput)
        {
            return; // 没有运算符或没有第二个数，不处理
        }

        // 提前声明第二个数变量，兼容C# 5
        double secondNumber;
        if (double.TryParse(txtDisplay.Text, out secondNumber))
        {
            double result = 0;
            bool isError = false;

            // 根据运算符执行运算
            switch (operation)
            {
                case "+":
                    result = firstNumber + secondNumber;
                    break;
                case "-":
                    result = firstNumber - secondNumber;
                    break;
                case "×":
                    result = firstNumber * secondNumber;
                    break;
                case "÷":
                    // 处理除数为0的情况
                    if (secondNumber == 0)
                    {
                        txtDisplay.Text = "错误：除数为0";
                        isError = true;
                        isNewInput = true;
                    }
                    else
                    {
                        result = firstNumber / secondNumber;
                    }
                    break;
            }

            // 显示结果（如果没有错误）
            if (!isError)
            {
                // 处理整数结果：如果是整数，显示为整数，否则显示小数
                txtDisplay.Text = result % 1 == 0 ? result.ToString("0") : result.ToString();
                isNewInput = true; // 标记为新输入，后续可直接输入新数字
                operation = ""; // 清空运算符
            }
        }
    }

    // 清空按钮（C）点击事件：重置所有状态
    private void ClearButton_Click(object sender, EventArgs e)
    {
        txtDisplay.Text = "0";
        firstNumber = 0;
        operation = "";
        isNewInput = true;
    }

    // 退格按钮（←）点击事件：删除最后一个字符
    private void BackspaceButton_Click(object sender, EventArgs e)
    {
        if (txtDisplay.Text.Length > 1)
        {
            txtDisplay.Text = txtDisplay.Text.Substring(0, txtDisplay.Text.Length - 1);
        }
        else
        {
            txtDisplay.Text = "0"; // 只剩一个字符时，重置为0
        }
    }

    // 程序入口点
    [STAThread] // WinForms必须的标记
    static void Main()
    {
        Application.EnableVisualStyles(); // 启用视觉样式，界面更美观
        Application.SetCompatibleTextRenderingDefault(false);
        Application.Run(new CalculatorForm()); // 启动计算器窗口
    }
}
```

## 2.另存为

1.修改文件名为Calculator.cs

2.选择所有文件

3.编码选ANSI

## 3.在文件目录下打开cmd控制台编译

>C:\Windows\Microsoft.NET\Framework\v4.0.30319\csc.exe /reference:System.Windows.Forms.dll /reference:System.Drawing.dll /target:winexe Calculator.cs

## 4.设置图标

### 1.在代码文件目录下放置ico图标

### 2.代码中怎么图标的代码

```csharp
    // 设置窗体图标
    this.Icon = Icon.ExtractAssociatedIcon(Application.ExecutablePath);
```

### 3.打包命令将图标打包

> C:\Windows\Microsoft.NET\Framework\v4.0.30319\csc.exe /reference:System.Windows.Forms.dll /reference:System.Drawing.dll /target:winexe /win32icon:temp.ico FileManager.cs

