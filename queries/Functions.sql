-- Função para inserir Server

select insertServer('server2'::text, '192.162.1.3'::text, 30);

CREATE OR REPLACE FUNCTION insertServer(serverName varchar(250), ipaddress_int varchar(250),
                                        WebSiteId_INT INT) RETURNS varchar AS
$$
BEGIN
    IF (SELECT haveserver
        FROM plansconfig
        WHERE planid = (SELECT websites.planid FROM websites WHERE websites.id = WebSiteId_INT limit 1)
        limit 1) = true THEN
        insert into servers (name, ipaddress, logadded, websiteid)
        values (serverName, ipaddress_int, NOW(), WebSiteId_INT);
        return 'Servidor Inserido com sucesso';
    else
        return 'Plano nao permite server';
    end if;

END
$$
    LANGUAGE 'plpgsql';

-- Função para inserir Database

select insertDatabase('wixdawish'::text, 5);

CREATE OR REPLACE FUNCTION insertDatabase(databaseName varchar(250),
                                          WebSiteId_INT INT) RETURNS varchar AS
$$
BEGIN
    IF (SELECT havedb
        FROM plansconfig
        WHERE planid = (SELECT websites.planid FROM websites WHERE websites.id = WebSiteId_INT limit 1)
        limit 1) = true THEN
        insert into databases (name, logadded, websiteid)
        values (databaseName, NOW(), WebSiteId_INT);
        return 'Database Inserido com sucesso';
    else
        return 'Plano nao permite database';
    end if;

END
$$
    LANGUAGE 'plpgsql';

-- Função para inserir SMTP

select insertSMTP('wix_smtp'::text, 5);

CREATE OR REPLACE FUNCTION insertSMTP(smtpName varchar(250),
                                      WebSiteId_INT INT) RETURNS varchar AS
$$
BEGIN
    IF (SELECT havesmtp
        FROM plansconfig
        WHERE planid = (SELECT websites.planid FROM websites WHERE websites.id = WebSiteId_INT limit 1)
        limit 1) = true THEN
        insert into smtp (name, logadded, websiteid)
        values (smtpName, NOW(), WebSiteId_INT);
        return 'SMTP Inserido com sucesso';
    else
        return 'Plano nao permite smtp';
    end if;

END
$$
    LANGUAGE 'plpgsql';

-- Função para inserir Domain

select insertDomain('www.wix-da-wish.com'::text, 5);

CREATE OR REPLACE FUNCTION insertDomain(domainName varchar(250),
                                        WebSiteId_INT INT) RETURNS varchar AS
$$
BEGIN
    IF (SELECT havedomains
        FROM plansconfig
        WHERE planid = (SELECT websites.planid FROM websites WHERE websites.id = WebSiteId_INT limit 1)
        limit 1) = true THEN
        insert into smtp (name, logadded, websiteid)
        values (domainName, NOW(), WebSiteId_INT);
        return 'Domain Inserido com sucesso';
    else
        return 'Plano nao permite domain';
    end if;

END
$$
    LANGUAGE 'plpgsql';

-- Função para inserir Ticket

select insertTicket('Erro crucial'::text, 'Falta a grade de cerveja', 30);

CREATE OR REPLACE FUNCTION insertTicket(ticketTitle varchar(250), ticketMessage varchar(250),
                                        WebSiteId_INT INT) RETURNS varchar AS
$$
BEGIN
    IF (SELECT havetickets
        FROM plansconfig
        WHERE planid = (SELECT websites.planid FROM websites WHERE websites.id = WebSiteId_INT limit 1)
        limit 1) = true THEN
        insert into tickets (title, message, logadded, websiteid)
        values (ticketTitle, ticketMessage, NOW(), WebSiteId_INT);
        return 'Ticket Inserido com sucesso';
    else
        return 'Plano nao permite ticket';
    end if;

END
$$
    LANGUAGE 'plpgsql';

-- Função para inserir CronJob

select insertCronjob('CronJobExample'::text, 'D://DLLs/crnjbexmpl', 'Daily', 30);

CREATE OR REPLACE FUNCTION insertCronjob(cronName varchar(250), cronPath varchar(250), cronTrigger trigger_cron,
                                         WebSiteId_INT INT) RETURNS varchar AS
$$
BEGIN
    IF (SELECT havecronjob
        FROM plansconfig
        WHERE planid = (SELECT websites.planid FROM websites WHERE websites.id = WebSiteId_INT limit 1)
        limit 1) = true THEN
        insert into cronjobs (name, pathdll, trigger, logadded)
        values (cronName, cronPath, cronTrigger, NOW());
        return 'CronJob Inserido com sucesso';
    else
        return 'Plano nao permite cronjob';
    end if;

END
$$
    LANGUAGE 'plpgsql';

-- Função para inserir Ads

select insertAds('Ferrari'::text, 5);

CREATE OR REPLACE FUNCTION insertAds(adsName varchar(250),
                                     WebSiteId_INT INT) RETURNS varchar AS
$$
BEGIN
    IF (SELECT haveads
        FROM plansconfig
        WHERE planid = (SELECT websites.planid FROM websites WHERE websites.id = WebSiteId_INT limit 1)
        limit 1) = true THEN
        insert into ads (name, logadded)
        values (adsName, NOW());
        return 'Ads Inserido com sucesso';
    else
        return 'Plano nao permite ads';
    end if;

END
$$
    LANGUAGE 'plpgsql';