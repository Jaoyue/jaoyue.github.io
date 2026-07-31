> HTML 页面: [[page/wiki/data/工作模块/线下门店/常用sql/GROUP_CONCAT查询试题.html|打开 HTML 页面]]

```plsql
set @n = 0;
select (@n := @n + 1) as '序号', t.试题内容,t.题型,t.难易度,t.选项 from 
(
select 
q.id,q.content '试题内容',
(case when q.type = 'multiple' then '多选'
when q.type = 'single' then '单选'
when q.type = 'filling' then '填空'
else '判断' end) '题型',
(case when q.difficulty_level = 'simple' then '简单'
when q.difficulty_level = 'normal' then '普通'
else '困难' end) '难易度',
GROUP_CONCAT(o.content,'(',(case when o.is_answer = '1' then '√' else 'x' end) SEPARATOR '),> ') '选项'
from sp_train_question q 
left join sp_train_question_option o on q.id = o.question_id
left join sp_train_question_classification c on q.category_id = c.id
where c.id = '16' and q.type <> 'trueOrFalse'
group by q.id
union all
select 
q.id,q.content '试题内容',
('判断') '题型',
(case when q.difficulty_level = 'simple' then '简单'
when q.difficulty_level = 'normal' then '普通'
else '困难' end) '难易度',
(case when q.answer = 'true' then '√' else 'x' end) '选项'
from sp_train_question q 
left join sp_train_question_option o on q.id = o.question_id
left join sp_train_question_classification c on q.category_id = c.id
where c.id = '16' and q.type = 'trueOrFalse'
group by q.id
) t order by t.id



select t.上级分类,t.试题分类,t.试题序号, t.试题内容,t.题型,t.难易度,t.选项 from 
(
select 
c2.category_name '上级分类',
c.category_name '试题分类',
q.id '试题序号',q.content '试题内容',
(case when q.type = 'multiple' then '多选'
when q.type = 'single' then '单选'
when q.type = 'filling' then '填空'
else '判断' end) '题型',
(case when q.difficulty_level = 'simple' then '简单'
when q.difficulty_level = 'normal' then '普通'
else '困难' end) '难易度',
GROUP_CONCAT(o.content,'(',(case when o.is_answer = '1' then '√)' else 'x)' end) SEPARATOR ',> ') '选项'
from sp_train_question q 
left join sp_train_question_option o on q.id = o.question_id
left join sp_train_question_classification c on q.category_id = c.id
left join sp_train_question_classification c2 on c.superior_category_id = c2.id
where c.id in (select id from sp_train_question_classification ) and q.type <> 'trueOrFalse'
group by q.id
union all
select 
c2.category_name '上级分类',
c.category_name '试题分类',
q.id '试题序号',q.content '试题内容',
('判断') '题型',
(case when q.difficulty_level = 'simple' then '简单'
when q.difficulty_level = 'normal' then '普通'
else '困难' end) '难易度',
(case when q.answer = 'true' then '√' else 'x' end) '选项'
from sp_train_question q 
left join sp_train_question_option o on q.id = o.question_id
left join sp_train_question_classification c on q.category_id = c.id
left join sp_train_question_classification c2 on c.superior_category_id = c2.id

where c.id in(select id from sp_train_question_classification ) and q.type = 'trueOrFalse'
group by q.id
) t order by t.`上级分类`,t.`试题分类`,t.试题序号


select t.上级分类,t.试题分类,t.试题序号, t.试题内容,t.题型,t.难易度,t.选项 from 
(
select 
c2.category_name '上级分类',
c.category_name '试题分类',
q.id '试题序号',q.content '试题内容',
(case when q.type = 'multiple' then '多选'
when q.type = 'single' then '单选'
when q.type = 'filling' then '填空'
else '判断' end) '题型',
(case when q.difficulty_level = 'simple' then '简单'
when q.difficulty_level = 'normal' then '普通'
else '困难' end) '难易度',
GROUP_CONCAT(o.content,'(',(case when o.is_answer = '1' then '√)' else 'x)' end) SEPARATOR ',> ') '选项'
from sp_train_question q 
left join sp_train_question_option o on q.id = o.question_id
left join sp_train_question_classification c on q.category_id = c.id
left join sp_train_question_classification c2 on c.superior_category_id = c2.id
where c.id in (select id from sp_train_question_classification where superior_category_id in (36,37,38,39,63) ) and q.type <> 'trueOrFalse'
group by q.id
union all
select 
c2.category_name '上级分类',
c.category_name '试题分类',
q.id '试题序号',q.content '试题内容',
('判断') '题型',
(case when q.difficulty_level = 'simple' then '简单'
when q.difficulty_level = 'normal' then '普通'
else '困难' end) '难易度',
(case when q.answer = 'true' then '√' else 'x' end) '选项'
from sp_train_question q 
left join sp_train_question_option o on q.id = o.question_id
left join sp_train_question_classification c on q.category_id = c.id
left join sp_train_question_classification c2 on c.superior_category_id = c2.id

where c.id in(select id from sp_train_question_classification where superior_category_id in (36,37,38,39,63) ) and q.type = 'trueOrFalse'
group by q.id
) t order by t.`上级分类`,t.`试题分类`,t.试题序号










```

