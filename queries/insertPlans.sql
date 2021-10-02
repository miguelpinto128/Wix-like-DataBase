SET search_path TO WixDaWish;

select * from PlansConfig

INSERT INTO Plans(Name, Price, Type, StorageSpace, LogAdded, LogUpdate)
VALUES ('Vip',24.50,'Personal','35GB','12-06-2021',null);
INSERT INTO PlansConfig (planId, HaveDB, HaveAds, HaveSMTP, HaveDomains, HaveServer, HaveTickets,HaveCronJob)
VALUES ((select Id from Plans order by Id desc limit 1),'1','1','1','1','1','1','1');

INSERT INTO Plans(Name, Price, Type, StorageSpace, LogAdded, LogUpdate)
VALUES ('Unlimited',12.50,'Personal','10GB','12-06-2021',null);
INSERT INTO PlansConfig (planId, HaveDB, HaveAds, HaveSMTP, HaveDomains, HaveServer, HaveTickets,HaveCronJob)
VALUES ((select Id from Plans order by Id desc limit 1),'1','1','1','1','1','1','1');

INSERT INTO Plans(Name, Price, Type, StorageSpace, LogAdded, LogUpdate)
VALUES ('Basic',8.50,'Personal','3GB','12-06-2021',null);
INSERT INTO PlansConfig (planId, HaveDB, HaveAds, HaveSMTP, HaveDomains, HaveServer, HaveTickets,HaveCronJob)
VALUES ((select Id from Plans order by Id desc limit 1),'1','1','0','1','1','1','1');

INSERT INTO Plans(Name, Price, Type, StorageSpace, LogAdded, LogUpdate)
VALUES ('Connect Domain',4.50,'Personal','500MB','12-06-2021',null);
INSERT INTO PlansConfig (planId, HaveDB, HaveAds, HaveSMTP, HaveDomains, HaveServer, HaveTickets,HaveCronJob)
VALUES ((select Id from Plans order by Id desc limit 1),'0','0','0','1','0','1','0');

INSERT INTO Plans(Name, Price, Type, StorageSpace, LogAdded, LogUpdate)
VALUES ('Business Vip',35,'Business','50GB','12-06-2021',null);
INSERT INTO PlansConfig (planId, HaveDB, HaveAds, HaveSMTP, HaveDomains, HaveServer, HaveTickets,HaveCronJob)
VALUES ((select Id from Plans order by Id desc limit 1),'1','1','1','1','1','1','1');

INSERT INTO Plans(Name, Price, Type, StorageSpace, LogAdded, LogUpdate)
VALUES ('Business Unlimited',25,'Business','35GB','12-06-2021',null);
INSERT INTO PlansConfig (planId, HaveDB, HaveAds, HaveSMTP, HaveDomains, HaveServer, HaveTickets,HaveCronJob)
VALUES ((select Id from Plans order by Id desc limit 1),'1','1','1','1','1','1','1');

INSERT INTO Plans(Name, Price, Type, StorageSpace, LogAdded, LogUpdate)
VALUES ('Business Basic',17,'Business','20GB','12-06-2021',null);
INSERT INTO PlansConfig (planId, HaveDB, HaveAds, HaveSMTP, HaveDomains, HaveServer, HaveTickets,HaveCronJob)
VALUES ((select Id from Plans order by Id desc limit 1),'0','1','0','1','0','1','0');