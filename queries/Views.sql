SET search_path TO WixDaWish;

-- Planos mais usados (> para <)
CREATE VIEW Most_Used_Plans AS
select p.name, count(*)from plans p
inner join websites w on p.id = w.planid
group by p.name
order by COUNT(p.id) desc;

-- Websites pagos
CREATE VIEW Paid_Websites AS
select w.name from websites w
where status = 'Paid';

-- Website de cada user
CREATE VIEW User_Websites AS
select u.firstname, w.name from users u
inner join websites w on u.id = w.userid
group by u.firstname, w.name;

-- Websites e seus planos
CREATE VIEW Websites_P AS
select w.name, p.name as plansName from plans p
inner join websites w on p.id = w.planid
group by p.name, w.name;

-- Templates e seus websites
CREATE VIEW Websites_T AS
select w.name, t.name as templatesName from templates t
inner join websites w on t.id = w.templateid
group by t.name, w.name
order by t.name;

-- Template mais usado
CREATE VIEW Most_Used_Templates AS
select t.name, count(*) from templates t
inner join websites w on t.id = w.templateid
group by t.name
order by COUNT(t.id) DESC;

-- Componentes usados nos templates
CREATE VIEW Templates_C AS
select t.name, c.name as componentName from components c
inner join templates_components tc on c.id = tc.componentid
inner join templates t on t.id = tc.templateid
group by t.name, c.name
order by t.name DESC;

-- Componentes usados nos websites com valores nas variadas línguas
CREATE VIEW Languages_Components_Websites AS
select w.name, c.name as componentName, wc.id, c2.name as countryName, wl.value from websites w
inner join website_components wc on w.id = wc.websiteid
inner join components c on wc.componentid = c.id
inner join websitecomponents_languages wl on wc.id = wl.websitecomponentid
inner join countries c2 on wl.countryid = c2.id
group by w.name, c.name, wc.id, c2.name, wl.value
order by w.name;

-- Websites e suas faturas com métodos de pagamento
CREATE VIEW Invoices_WSites AS
select w.name, i.date, p.name as paymentMethod from websites w
inner join invoices i on w.id = i.websiteid
inner join paymentmethods p on i.paymentmethodid = p.id
group by w.name, i.date, p.name;

-- Users e os seus dados
CREATE VIEW Users_Data AS
select concat(firstname, ' ', lastname) as fullname, u.id as usID, email, password, lastlogin, lastlogout, googletoken, facebooktoken, cookietoken, logupdate, logadded, u2.id, nif, address, phonenumber, gender, birthdate, type, userid, countryid from users u
inner join usersdata u2 on u.id = u2.userid
order by fullname;

-- Planos e as suas configs
CREATE VIEW Plans_Configs AS
select p.name, p2.* from plans p
inner join plansconfig p2 on p.id = p2.planid;

-- Websites com as suas configs
CREATE VIEW Websites_Configs AS
select w.name, p.name as planName, p2.* from websites w
inner join plans p on w.planid = p.id
inner join plansconfig p2 on p.id = p2.planid;

-- Tickets de Websites
CREATE VIEW Websites_Tickets AS
select w.name, t.message from tickets t
inner join websites w on w.id = t.websiteid
group by w.name, t.message
order by w.name;

-- Websites e seus ads
CREATE VIEW Websites_A AS
select w.name, a.name as adsName from websites w
inner join websites_ads wa on w.id = wa.websiteid
inner join ads a on a.id = wa.adsid
group by w.name, a.name
order by w.name;

-- Websites e seus cronjobs
CREATE VIEW Websites_CJ AS
select w.name, c.name as cronjobname from websites w
inner join websites_cronjobs wc on w.id = wc.websiteid
inner join cronjobs c on c.id = wc.cronjobid
group by w.name, c.name
order by w.name;

-- user com nenhum website
CREATE VIEW User_No_Website AS
select u.firstname
from users u
left join websites w on w.userid = u.id
where w.id is null;

-- user com mais do que 1 website
CREATE VIEW More_Than_1_Website AS
select w.userid, u.firstname, count(*)
from users u
inner join websites w on w.userid = u.id
group by w.userid, u.firstname
having count(*) > 1
order by count(u.id) DESC;

-- plans com smtp
CREATE VIEW Plans_SMTP AS
select pc.id, p.name
from Plans p
inner join plansconfig pc on pc.planid = p.id
where pc.havesmtp = True;

--quantos planos sao planos pessoais
CREATE VIEW Personal_Plans AS
select p.id, p.name, p.type
from plans p
where p.type = 'Personal';

--user do tipo Web Developer
CREATE VIEW WD_Users AS
select u.id, u.firstname, ud.type
from users u
inner join usersdata ud on u.id = ud.userid
where ud.type = 'Web Developer';

-- user de portugal
CREATE VIEW users_from_portugal AS
select u.firstname, c.name
from countries c
inner join usersdata ud on ud.countryid  = c.id
inner join users u on ud.userid = u.id
where ud.countryid = '145';

-- User do sexo masculino
CREATE VIEW Gender_Male AS
select concat(firstname, ' ', lastname) as fullname, u2.gender
from users u
inner join usersdata u2 on u.id = u2.userid
where u2.gender = 'Male'
order by fullname DESC ;

-- User do sexo feminino
CREATE VIEW Gender_Female AS
select concat(firstname, ' ', lastname) as fullname, u2.gender
from users u
inner join usersdata u2 on u.id = u2.userid
where u2.gender = 'Female'
order by fullname DESC ;

-- Templates de planos
CREATE VIEW Templates_Of_Plans AS
select t.name, t.id, p.id as planID from templates t
inner join plans_templates pt on t.id = pt.templateid
inner join plans p on pt.planid = p.id
order by p.id;

-- Sites em que o template nao está no plano
select * from websites w
left join plans_templates pt on pt.planid = w.planid and pt.templateid = w.templateid
where pt.id is null;

-- Componente em site mas não no template
select w.id, w.templateid,tc.templateid, tc.componentid, wc.componentid, wc.websiteid from websites w
left join templates_components tc on tc.templateid = w.templateid
left join website_components wc on wc.websiteid = w.id and wc.componentid = tc.componentid
where wc.id is null
order by w.id;