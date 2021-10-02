create schema WixDaWish;
SET search_path TO WixDaWish;



--ENUMS
CREATE TYPE Component_Status AS ENUM ('Active', 'Disabled', 'Maintenance');
CREATE TYPE Trigger_Cron AS ENUM ('Hourly', 'Daily','Weekly', 'Monthly');
CREATE TYPE Gender AS ENUM ('Male', 'Female');
CREATE TYPE Type_Acount AS ENUM ('Designer', 'Backend Developer', 'Web Developer', 'Full Stack Developer', 'Student');
CREATE TYPE Payment_Status AS ENUM ('Paid', 'In progress', 'Created');
CREATE TYPE PlanType AS ENUM ('Personal', 'Business');

--TABLES
CREATE TABLE Users
(
    Id            SERIAL PRIMARY KEY,
    FirstName     varchar(250) not null,
    LastName      varchar(250) not null,
    Email         varchar(250) not null,
    Password      varchar(250) not null,
    LastLogin     timestamp    null,
    LastLogOut    timestamp    null,
    GoogleToken   varchar(250) null,
    FacebookToken varchar(250) null,
    CookieToken   varchar(250) null,
    LogUpdate     timestamp    null,
    LogAdded      timestamp    not null
);

CREATE TABLE UsersData
(
    Id          SERIAL PRIMARY KEY,
    NIF         varchar(250) not null,
    Address     varchar(250) not null,
    PhoneNumber varchar(150)      null,
    Gender      Gender       null,
    Birthdate   timestamp    null,
    Type        Type_Acount  null
);

CREATE TABLE Websites
(
    Id        SERIAL PRIMARY KEY,
    Name      varchar(250)   not null,
    Status    Payment_Status not null,
    LogUpdate timestamp      null,
    LogAdded  timestamp      not null
);

CREATE TABLE Invoices
(
    Id        SERIAL PRIMARY KEY,
    date      timestamp    not null,
    reference varchar(250) not null,
    qrCode    varchar(500) not null,
    LogUpdate timestamp    null,
    LogAdded  timestamp    not null
);

CREATE TABLE Website_Components
(
    Id        SERIAL PRIMARY KEY,
    xCoord    decimal   not null,
    yCoord    decimal   not null,
    LogUpdate timestamp null,
    LogAdded  timestamp not null
);

CREATE TABLE WebsiteComponents_Languages
(
    Id        SERIAL PRIMARY KEY,
    value     varchar(150) not null,
    LogUpdate timestamp    null,
    LogAdded  timestamp    not null
);

CREATE TABLE Countries
(
    Id        SERIAL PRIMARY KEY,
    Name      varchar(250) not null,
    PathFlag  varchar(250) not null,
    LogUpdate timestamp    null,
    LogAdded  timestamp    not null
);

CREATE TABLE PaymentMethods
(
    Id        SERIAL PRIMARY KEY,
    Name      varchar(250) not null,
    LogUpdate timestamp    null,
    LogAdded  timestamp    not null
);

CREATE TABLE Companies
(
    Id        SERIAL PRIMARY KEY,
    Name      varchar(250) not null,
    LogUpdate timestamp    null,
    LogAdded  timestamp    not null
);

CREATE TABLE Components
(
    Id        SERIAL PRIMARY KEY,
    Name      varchar(250)     not null,
    HTML_Path varchar(250)     not null,
    Status    Component_Status not null,
    LogAdded  timestamp        not null,
    LogUpdate timestamp        null
);

CREATE TABLE Templates
(
    Id        SERIAL PRIMARY KEY,
    Name      varchar(250) not null,
    LogAdded  timestamp    not null,
    LogUpdate timestamp    null
);

CREATE TABLE Plans
(
    Id           SERIAL PRIMARY KEY,
    Name         varchar(250) not null,
    Price        decimal      not null,
    Type         PlanType not null,
    StorageSpace varchar(150)          not null,
    LogAdded     timestamp    not null,
    LogUpdate    timestamp    null

);

CREATE TABLE PlansConfig
(
    Id          SERIAL PRIMARY KEY,
    HaveDB      boolean,
    HaveAds     boolean,
    HaveSMTP    boolean,
    HaveDomains boolean,
    HaveServer  boolean,
    HaveTickets boolean,
    HaveCronJob boolean

);

CREATE TABLE Domains
(
    Id        SERIAL PRIMARY KEY,
    Name      varchar(250) not null,
    LogUpdate timestamp    null,
    LogAdded  timestamp    not null
);

CREATE TABLE Servers
(
    Id        SERIAL PRIMARY KEY,
    Name      varchar(250) not null,
    IpAddress varchar(250) not null,
    LogUpdate timestamp    null,
    LogAdded  timestamp    not null
);

CREATE TABLE Smtp
(
    Id        SERIAL PRIMARY KEY,
    Name      varchar(250) not null,
    LogUpdate timestamp    null,
    LogAdded  timestamp    not null
);

CREATE TABLE DataBases
(
    Id        SERIAL PRIMARY KEY,
    Name      varchar(250) not null,
    LogUpdate timestamp    null,
    LogAdded  timestamp    not null
);

CREATE TABLE Tickets
(
    Id        SERIAL PRIMARY KEY,
    Title     varchar(250) not null,
    Message   varchar(250) not null,
    LogUpdate timestamp    null,
    LogAdded  timestamp    not null
);

CREATE TABLE Ads
(
    Id        SERIAL PRIMARY KEY,
    Name      varchar(250) not null,
    LogAdded  timestamp    not null,
    LogUpdate timestamp    null

);

CREATE TABLE CronJobs
(
    Id        SERIAL PRIMARY KEY,
    Name      varchar(250) not null,
    PathDLL   varchar(250) not null,
    Trigger   Trigger_Cron not null,
    LogAdded  timestamp    not null,
    LogUpdate timestamp    null

);


CREATE TABLE Plans_Templates
(
    Id         SERIAL PRIMARY KEY,
    PlanId     int       not null,
    templateId int       not null,
    LogUpdate  timestamp null,
    LogAdded   timestamp not null
);


CREATE TABLE Templates_Components
(
    Id          SERIAL PRIMARY KEY,
    componentId int       not null,
    templateId  int       not null,
    LogUpdate   timestamp null,
    LogAdded    timestamp not null
);

CREATE TABLE Websites_Ads
(
    Id        SERIAL PRIMARY KEY,
    adsId     int       not null,
    websiteId int       not null,
    LogUpdate timestamp null,
    LogAdded  timestamp not null
);

CREATE TABLE Websites_CronJobs
(
    Id        SERIAL PRIMARY KEY,
    websiteId int       not null,
    cronjobId int       not null,
    LogUpdate timestamp null,
    LogAdded  timestamp not null
);


--CONSTRAINTS

ALTER TABLE UsersData
    ADD COLUMN userId int UNIQUE not null;
ALTER TABLE UsersData
    ADD COLUMN countryId int;
ALTER TABLE UsersData
    ADD CONSTRAINT usersdata_user_fkey FOREIGN KEY (userId) REFERENCES users (id);
ALTER TABLE UsersData
    ADD CONSTRAINT usersdata_userData_fkey FOREIGN KEY (countryId) REFERENCES countries (id);


ALTER TABLE Websites
    ADD COLUMN userId int not null;
ALTER TABLE Websites
    ADD COLUMN planId int not null;
ALTER TABLE Websites
    ADD COLUMN templateId int not null;
ALTER TABLE Websites
    ADD CONSTRAINT websites_users_fkey FOREIGN KEY (userId) REFERENCES users (id);
ALTER TABLE Websites
    ADD CONSTRAINT websites_plans_fkey FOREIGN KEY (planId) REFERENCES Plans (id);
ALTER TABLE Websites
    ADD CONSTRAINT websites_templates_fkey FOREIGN KEY (templateId) REFERENCES Templates (id);

ALTER TABLE Invoices
    ADD COLUMN websiteId int UNIQUE not null;
ALTER TABLE Invoices
    ADD COLUMN paymentmethodId int not null;
ALTER TABLE Invoices
    ADD COLUMN companyId int not null;
ALTER TABLE Invoices
    ADD CONSTRAINT invoices_websites_fkey FOREIGN KEY (websiteId) REFERENCES Websites (id);
ALTER TABLE Invoices
    ADD CONSTRAINT invoices_paymentmethods_fkey FOREIGN KEY (paymentmethodId) REFERENCES PaymentMethods (id);
ALTER TABLE Invoices
    ADD CONSTRAINT invoices_companies_fkey FOREIGN KEY (companyId) REFERENCES Companies (id);

ALTER TABLE Website_Components
    ADD COLUMN websiteId int not null;
ALTER TABLE Website_Components
    ADD COLUMN componentId int not null;
ALTER TABLE Website_Components
    ADD CONSTRAINT website_components_websites_fkey FOREIGN KEY (websiteId) REFERENCES Websites (id);
ALTER TABLE Website_Components
    ADD CONSTRAINT website_components_components_fkey FOREIGN KEY (componentId) REFERENCES components (id);

ALTER TABLE WebsiteComponents_Languages
    ADD COLUMN websitecomponentId int not null;
ALTER TABLE WebsiteComponents_Languages
    ADD COLUMN CountryId int not null;
ALTER TABLE WebsiteComponents_Languages
    ADD CONSTRAINT websitecomponents_languages_websitecomponents_fkey FOREIGN KEY (websitecomponentId) REFERENCES website_components (id);
ALTER TABLE WebsiteComponents_Languages
    ADD CONSTRAINT websitecomponents_languages_languages_fkey FOREIGN KEY (CountryId) REFERENCES countries (id);


ALTER TABLE Tickets
    ADD COLUMN websiteId int;
ALTER TABLE Tickets
    ADD CONSTRAINT tickets_WebSites_fkey FOREIGN KEY (websiteID) REFERENCES Websites (id);

ALTER TABLE Domains
    ADD COLUMN websiteId int UNIQUE;
ALTER TABLE Domains
    ADD CONSTRAINT Domains_WebSite_fkey FOREIGN KEY (websiteId) REFERENCES Websites (id);

ALTER TABLE Servers
    ADD COLUMN websiteId int UNIQUE;
ALTER TABLE Servers
    ADD CONSTRAINT Servers_Website_fkey FOREIGN KEY (websiteId) REFERENCES Websites (id);

ALTER TABLE Smtp
    ADD COLUMN websiteId int UNIQUE;
ALTER TABLE Smtp
    ADD CONSTRAINT Smtp_Website_fkey FOREIGN KEY (websiteId) REFERENCES Websites (id);

ALTER TABLE DataBases
    ADD COLUMN websiteId int UNIQUE;
ALTER TABLE DataBases
    ADD CONSTRAINT DataBases_Website_fkey FOREIGN KEY (websiteId) REFERENCES Websites (id);


ALTER TABLE PlansConfig
    ADD COLUMN planId int UNIQUE;
ALTER TABLE PlansConfig
    ADD CONSTRAINT plansConfig_plans_fkey FOREIGN KEY (planId) REFERENCES Plans (id);


ALTER TABLE PlansConfig
    ADD COLUMN planId int UNIQUE not null;
ALTER TABLE PlansConfig
    ADD CONSTRAINT plansConfig_plans_fkey FOREIGN KEY (planId) REFERENCES Plans (id);

ALTER TABLE Plans_Templates
    ADD CONSTRAINT plans_templates_plans_fkey FOREIGN KEY (planId) REFERENCES Plans (id);
ALTER TABLE Plans_Templates
    ADD CONSTRAINT plans_templates_template_fkey FOREIGN KEY (planId) REFERENCES Templates (id);

ALTER TABLE Templates_Components
    ADD CONSTRAINT templates_components_templates_fkey FOREIGN KEY (templateId) REFERENCES Templates (id);
ALTER TABLE Templates_Components
    ADD CONSTRAINT templates_components_components_fkey FOREIGN KEY (componentId) REFERENCES Components (id);

ALTER TABLE Websites_Ads
    ADD CONSTRAINT websites_ads_ads_fkey FOREIGN KEY (adsId) REFERENCES Ads (id);
ALTER TABLE Websites_Ads
    ADD CONSTRAINT websites_ads_website_fkey FOREIGN KEY (websiteId) REFERENCES websites (id);

ALTER TABLE Websites_CronJobs
    ADD CONSTRAINT websites_cronjobs_ads_fkey FOREIGN KEY (cronjobId) REFERENCES cronjobs (id);
ALTER TABLE Websites_CronJobs
    ADD CONSTRAINT websites_ads_website_fkey FOREIGN KEY (websiteId) REFERENCES websites (id);