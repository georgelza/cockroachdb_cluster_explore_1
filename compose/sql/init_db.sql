-- ── Database ────────────────────────────────────────────────────────────────
CREATE DATABASE IF NOT EXISTS demog;

-- ── Schema ──────────────────────────────────────────────────────────────────
CREATE SCHEMA IF NOT EXISTS demog.public;

-- ── Tables ──────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS demog.public.accountholders (
     _id                      SERIAL        NOT NULL
    ,nationalid               VARCHAR(16)   NOT NULL
    ,firstname                VARCHAR(100)
    ,lastname                 VARCHAR(100)
    ,dob                      VARCHAR(10)
    ,gender                   VARCHAR(10)
    ,children                 INTEGER
    ,address                  JSONB
    ,accounts                 JSONB
    ,emailaddress             VARCHAR(100)
    ,mobilephonenumber        VARCHAR(20)
    ,created_at               TIMESTAMPTZ   DEFAULT NOW() NOT NULL
    ,PRIMARY KEY              (_id)
);

CREATE TABLE IF NOT EXISTS demog.public.transactions (
     _id                            SERIAL        NOT NULL
    ,eventid                        VARCHAR(36)   NOT NULL
    ,transactionid                  VARCHAR(36)   NOT NULL
    ,eventtime                      VARCHAR(30)
    ,direction                      VARCHAR(8)
    ,eventtype                      VARCHAR(10)
    ,creationdate                   VARCHAR(20)
    ,accountholdernationalId        VARCHAR(16)
    ,accountholderaccount           JSONB
    ,counterpartynationalId         VARCHAR(16)
    ,counterpartyaccount            JSONB
    ,tenantid                       VARCHAR(8)
    ,fromid                         VARCHAR(8)
    ,accountagentid                 VARCHAR(8)
    ,fromfibranchid                 VARCHAR(6)
    ,accountnumber                  VARCHAR(16)
    ,toid                           VARCHAR(8)
    ,accountidcode                  VARCHAR(5)
    ,counterpartyagentid            VARCHAR(8)
    ,tofibranchid                   VARCHAR(6)
    ,counterpartynumber             VARCHAR(16)
    ,counterpartyidcode             VARCHAR(5)
    ,amount                         JSONB
    ,msgtype                        VARCHAR(6)
    ,settlementclearingsystemcode   VARCHAR(5)
    ,paymentclearingsystemreference VARCHAR(12)
    ,requestexecutiondate           VARCHAR(10)
    ,settlementdate                 VARCHAR(10)
    ,destinationcountry             VARCHAR(30)
    ,localinstrument                VARCHAR(2)
    ,msgstatus                      VARCHAR(12)
    ,paymentmethod                  VARCHAR(4)
    ,settlementmethod               VARCHAR(4)
    ,transactiontype                VARCHAR(2)
    ,verificationresult             VARCHAR(4)
    ,numberoftransactions           INTEGER
    ,schemaversion                  INTEGER
    ,usercode                       VARCHAR(4)
    ,created_at                     TIMESTAMPTZ   DEFAULT NOW() NOT NULL
    ,PRIMARY KEY                    (_id)
);

-- ── Indexes ──────────────────────────────────────────────────────────────────
CREATE INDEX IF NOT EXISTS accountholders_nationalid_idx ON demog.public.accountholders(nationalid);
CREATE INDEX IF NOT EXISTS transactions_eventid_idx      ON demog.public.transactions(eventid);
CREATE INDEX IF NOT EXISTS transactions_txnid_idx        ON demog.public.transactions(transactionid);