select * from sp_train_question
select * from sp_train_question_classification

select c.category_name 分类,q.content 题目,q.explanation 答案,
case
when q.type = 'single' then '单选题'
when q.type = 'multiple' then '多选题'
when q.type = 'trueOrFalse' then '判断题'
when q.type = 'filling' then '填空题'
when q.type = 'question' then '问答题'
when q.type = 'recording' then '录音题' end 类型
from sp_train_question q
join sp_train_question_classification c on q.category_id = c.id