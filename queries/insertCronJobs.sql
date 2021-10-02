SET search_path TO WixDaWish;

'Hourly', 'Daily','Weekly', 'Monthly'

INSERT INTO CronJobs (name, PathDLL, Trigger, LogAdded, LogUpdate)
VALUES ('Send Email','D://DLLs/sendemail','Daily','12-06-2021',null);

INSERT INTO CronJobs (name, PathDLL, Trigger, LogAdded, LogUpdate)
VALUES ('Processing Invoices','D://DLLs/processinginvoices','Hourly','12-06-2021',null);

INSERT INTO CronJobs (name, PathDLL, Trigger, LogAdded, LogUpdate)
VALUES ('Payment Processing','D://DLLs/paymentprocessing','Weekly','12-06-2021',null);

INSERT INTO CronJobs (name, PathDLL, Trigger, LogAdded, LogUpdate)
VALUES ('RGPD','D://DLLs/rgpd','Hourly','12-06-2021',null);

INSERT INTO CronJobs (name, PathDLL, Trigger, LogAdded, LogUpdate)
VALUES ('Events','D://DLLs/evnt','Monthly','12-06-2021',null);

INSERT INTO CronJobs (name, PathDLL, Trigger, LogAdded, LogUpdate)
VALUES ('Send Ad','D://DLLs/sendad','Hourly','12-06-2021',null);