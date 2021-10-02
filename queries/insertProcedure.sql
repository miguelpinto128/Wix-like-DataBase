SET search_path TO WixDaWish;


call CreateWebsite(21, 3, 2, 'Wix'::text, 3);
call CreateWebSiteComponents(32, 100.10, 900, 32, '{145,192}', '{"Olá","Hello"}');
call createuser('Marco', 'Oliveira', 'marco_oliveira69@gmail.com', 'marquinhos', 250113954, 'Rua do Ribaltas',
                917773377, 'Male', '05-29-2002', 'Web Developer', '145');

create or replace procedure CreateWebSiteComponents(
    webSiteId_int int,
    xcoord_int decimal,
    ycoord_int decimal,
    compnentId_int int,
    languages_int int[],
    values_int varchar[]
)
    language plpgsql
as
$$
DECLARE
    languageId_int      INT;
    languageId_int_aux  INT;
    values_int_aux      varchar;
    i                   INT;
    languages_int_count int=0;
    values_int_count    int =0;
    error               boolean = true;
begin

    FOREACH languageId_int_aux IN ARRAY languages_int
        LOOP
            languages_int_count = languages_int_count + 1;
        END LOOP;

        FOREACH values_int_aux IN ARRAY values_int
            LOOP
                values_int_count = values_int_count + 1;
            END LOOP;
        if values_int_count = languages_int_count then
            error = false;
        else
            error = true;
        end if;
    if error = true then
        RAISE NOTICE 'Erro arrays incorretos';
    else

                if (select count(*)
                    from templates_components
                    where templateid =
                          (select websites.templateid from websites where websites.id = webSiteId_int limit 1)
                      and componentid = compnentId_int) > 0 then
                    INSERT INTO website_components(xcoord, ycoord, logadded, websiteid, componentid)
                    VALUES (xcoord_int, ycoord_int, NOW(), webSiteId_int, compnentId_int);
                    i = 0;
                    FOREACH languageId_int IN ARRAY languages_int
                        LOOP
                            if (select count(*) from countries where id = languageId_int) > 0 then
                                i = i + 1;
                                INSERT INTO websitecomponents_languages(logadded, websitecomponentid, countryId, value)
                                values (now(), (select id from website_components order by id desc limit 1),
                                        languageId_int, values_int[i]);
                            else
                                RAISE NOTICE 'País não existe';
                            end if;
                        END LOOP;
                else
                    RAISE NOTICE 'Componente não existe no template selecionado';
                end if;
        commit;
    end if;
end;
$$;

create or replace procedure CreateWebSite(
    userId_int int,
    templateId_int int,
    planId_int int,
    name_int text,
    paymentmethod_int int)
    language plpgsql
as
$$
begin
    if (select count(*) from plans_templates where planid = planId_int and templateid = templateId_int) > 0 then
        INSERT INTO websites(Name, Status, LogAdded, PlanId, UserId, TemplateId)
        VALUES (name_int, 'Created', now(), planId_int, userId_int, templateId_int);

        INSERT INTO Invoices(companyid, websiteId, paymentmethodId, date, reference, qrCode, LogAdded)
        VALUES (1, (select id from websites order by id desc limit 1), paymentmethod_int, now(),
                uuid_in(md5(random()::text || clock_timestamp()::text)::cstring),
                'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/QR_code_for_mobile_English_Wikipedia.svg/1200px-QR_code_for_mobile_English_Wikipedia.svg.png',
                now());

        commit;
    else
        RAISE NOTICE 'Template não existe no plano selecionado';
    end if;
end;
$$;

create or replace procedure CreateUser(
    firstname_int text,
    lastname_int text,
    email_int text,
    password_int text,
    nif_int int,
    address_int text,
    phonenumber_int int,
    gender_int gender,
    birthdate_int date,
    type_int type_acount,
    countryid_int int)
    language plpgsql
as
$$
begin
    INSERT INTO users(firstname, lastname, email, password, googletoken, facebooktoken, cookietoken, logadded)
    VALUES (firstname_int, lastname_int, email_int, password_int, '', '', '', now());

    INSERT INTO usersdata(nif, address, phonenumber, gender, birthdate, type, userid, countryid)
    VALUES (nif_int, address_int, phonenumber_int, gender_int, birthdate_int, type_int,
            (select id from users order by id desc limit 1), countryid_int);

    commit;
end
$$;

create or replace procedure CreateUser(
    firstname_int text,
    lastname_int text,
    email_int text,
    password_int text,
    nif_int int,
    address_int text,
    phonenumber_int int,
    gender_int gender,
    birthdate_int date,
    type_int type_acount,
    is_google boolean,
    token varchar,
    countryid_int int)
    language plpgsql
as
$$
begin
    INSERT INTO users(firstname, lastname, email, password, googletoken, facebooktoken, cookietoken, logadded)
    VALUES (firstname_int, lastname_int, email_int, password_int, case
                                                                      when is_google = true then token
                                                                      else ''
        end, case
                 when is_google = false then token
                 else ''
                end,
            uuid_in(md5(random()::text || clock_timestamp()::text)::cstring), now());

    INSERT INTO usersdata(nif, address, phonenumber, gender, birthdate, type, userid, countryid)
    VALUES (nif_int, address_int, phonenumber_int, gender_int, birthdate_int, type_int,
            (select id from users order by id desc limit 1), countryid_int);

    commit;
end
$$;

call createuser('Bruno', 'Faria', 'bruno_faria@gmail.com', 'faria', 250113954, 'Paredes',
                '917773377', 'Male', '05-29-2002', 'Web Developer', true , '7sZR2366e44z23323' ,'145');
                
create or replace procedure CreateUser(
    firstname_int text,
    lastname_int text,
    email_int text,
    password_int text,
    nif_int int,
    address_int text,
    phonenumber_int int,
    gender_int gender,
    birthdate_int date,
    type_int type_acount,
    is_google boolean,
    token varchar,
    countryid_int int)
    language plpgsql
as
$$
begin
    INSERT INTO users(firstname, lastname, email, password, googletoken, facebooktoken, cookietoken, logadded)
    VALUES (firstname_int, lastname_int, email_int, password_int, case
                                                                      when is_google = true then token
                                                                      else ''
        end, case
                 when is_google = false then token
                 else ''
                end,
            uuid_in(md5(random()::text || clock_timestamp()::text)::cstring), now());

    INSERT INTO usersdata(nif, address, phonenumber, gender, birthdate, type, userid, countryid)
    VALUES (nif_int, address_int, phonenumber_int, gender_int, birthdate_int, type_int,
            (select id from users order by id desc limit 1), countryid_int);

    commit;
end
$$;