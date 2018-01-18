use mydb_lxia;
DROP TABLE IF EXISTS AGREEMENTINVOICE_T;
DROP TABLE IF EXISTS AGREEMENT_T;
DROP TABLE IF EXISTS ARTISTDEGREE_T;
DROP TABLE IF EXISTS ARTISTEXPENSE_T;
DROP TABLE IF EXISTS ARTISTHONOR_T;
DROP TABLE IF EXISTS ARTISTINSTRUMENT_T;
DROP TABLE IF EXISTS ARTISTNEWS_T;
DROP TABLE IF EXISTS ARTISTPAYMENT_T;
DROP TABLE IF EXISTS ADMIN_T;
DROP TABLE IF EXISTS ARTISTMGREXPENSE_T;
DROP TABLE IF EXISTS CONTRACT_T;
DROP TABLE IF EXISTS DEGREE_T;
DROP TABLE IF EXISTS EXPENSE_T;
DROP TABLE IF EXISTS HONOR_T;
DROP TABLE IF EXISTS INSTRUMENT_T;
DROP TABLE IF EXISTS INVOICEPAYMENT_T;
DROP TABLE IF EXISTS CUSTOMERPAYMENT_T;
DROP TABLE IF EXISTS NEWSITEM_T;
DROP TABLE IF EXISTS PERSONALC_T;
DROP TABLE IF EXISTS PERFORMANCERELATEDC_T;
DROP TABLE IF EXISTS RECOMMENDATION_T;
DROP TABLE IF EXISTS PROSPECTIVEARTIST_T;
DROP TABLE IF EXISTS SAMPLE_T;
DROP TABLE IF EXISTS SOURCE_T;
DROP TABLE IF EXISTS ARTISTCOMMITMENT_T;
DROP TABLE IF EXISTS INVOICE_T;
DROP TABLE IF EXISTS EVENT_T;
DROP TABLE IF EXISTS CUSTOMER_T;
DROP TABLE IF EXISTS CONTRACTEDARTIST_T;
DROP TABLE IF EXISTS ARTISTMANAGER_T;
DROP TABLE IF EXISTS ARTIST_T;
DROP TABLE IF EXISTS VENUE_T;


CREATE TABLE ADMIN_T
  ( AdminID		    BIGINT(12)    NOT NULL,	
    LastName		  VARCHAR(25)  NOT NULL,	
    FirstName		  VARCHAR(25)  NOT NULL,	
    AManagerID	  BIGINT(12)    NOT NULL,
    CONSTRAINT PK_ADMINT_T PRIMARY KEY (AdminID));

CREATE TABLE AGREEMENT_T
  ( AgreementNbr		    BIGINT(12)    NOT NULL,
    AgreementDate		    DATE     NOT NULL,
    GrossAmount		      NUMERIC(12,2)  NOT NULL,
    AtSourceTaxWithheld	NUMERIC(12,2)  NOT NULL,
    EventID             BIGINT(12)    NOT NULL,
    ContractID          BIGINT(12)    NOT NULL,
    CONSTRAINT PK_AGREEMENT_T PRIMARY KEY (AgreementNbr));

CREATE TABLE ARTIST_T
  ( ArtistID		  BIGINT(12)          NOT NULL,
    LastName		  VARCHAR(25)        NOT NULL,
    FirstName		  VARCHAR(25)        NOT NULL,
    Gender		    CHAR(1)             NOT NULL,
    YearOfBirth		BIGINT(4)           NOT NULL,
    Street        VARCHAR(40),
    City          VARCHAR(30),
    State         VARCHAR(2),
    Zip           VARCHAR(9),
    Phone         CHAR(10)            NOT NULL,
    Email         VARCHAR(50)        NOT NULL,
    ArtistType    CHAR(1)             NOT NULL,
    CONSTRAINT CH_ArtistType CHECK
      (ArtistType IN ('C','P')),
    CONSTRAINT PK_ARTIST_T PRIMARY KEY (ArtistID));
    
CREATE TABLE ARTISTCOMMITMENT_T
  ( ACommitmentID	  BIGINT(12)  NOT NULL,
    StartDateTime	  VARCHAR(255)   NOT NULL,
    EndDateTime		  VARCHAR(255)   NOT NULL,
    ArtistID		    BIGINT(12)  NOT NULL,
    CommitmentType	CHAR(2)     NOT NULL,
    CONSTRAINT CH_CommitmentType CHECK
      (CommitmentType IN ('PE','PR')),
    CONSTRAINT PK_ARTISTCOMMITMENT_T PRIMARY KEY (ACommitmentID));

CREATE TABLE ARTISTDEGREE_T
  ( ArtistID      BIGINT(12)    NOT NULL,
    DegreeID      BIGINT(12)    NOT NULL,
    DegreeYear    BIGINT(4)     NOT NULL,
    CONSTRAINT CH_DegreeYear CHECK
      (DegreeYear < 2015),
    CONSTRAINT PK_ARTISTDEGREE_T PRIMARY KEY (ArtistID, DegreeID));
  
CREATE TABLE ARTISTEXPENSE_T
  ( ExpenseID    BIGINT(12)    NOT NULL,
    ArtistID     BIGINT(12)    NOT NULL,
    CONSTRAINT PK_ARTISTEXPENSE_T PRIMARY KEY (ExpenseID));

CREATE TABLE ARTISTHONOR_T
  ( ArtistID   BIGINT(12)    NOT NULL,
    HonorID     BIGINT(12)    NOT NULL,
    AHYear      BIGINT(4),
    CONSTRAINT PK_ARTISTHONOR_T PRIMARY KEY (ArtistID, HonorID));    
    
CREATE TABLE ARTISTINSTRUMENT_T
  ( ArtistID      BIGINT(12)    NOT NULL,
    InstrumentID  BIGINT(12)    NOT NULL,
    CONSTRAINT PK_ARTISTINSTRUMENT_T PRIMARY KEY (ArtistID, InstrumentID));

CREATE TABLE ARTISTMANAGER_T
  ( AManagerID		BIGINT(12)    NOT NULL,
    LastName		  VARCHAR(25)  NOT NULL,
    FirstName		  VARCHAR(25)  NOT NULL,
    CONSTRAINT PK_ARTISTMANAGER_T PRIMARY KEY (AManagerID));

CREATE TABLE ARTISTNEWS_T
  ( ArtistID      BIGINT(12)    NOT NULL,
    NewsItemID    BIGINT(12)    NOT NULL,
    CONSTRAINT PK_ARTISTNEWS_T PRIMARY KEY (ArtistID, NewsItemID));
    
CREATE TABLE ARTISTPAYMENT_T
  ( APaymentID    BIGINT(12)    NOT NULL,
    APaymentDate  DATE     NOT NULL,
    Amount        NUMERIC(12,2)  NOT NULL,
    ArtistID      BIGINT(12)    NOT NULL,
    AdminID       BIGINT(12)    NOT NULL,
    CONSTRAINT PK_ARTISTPAYMENT_T PRIMARY KEY (APaymentID));
    
CREATE TABLE ARTISTMGREXPENSE_T
  ( ExpenseID    BIGINT(12)    NOT NULL,
    AManagerID   BIGINT(12)    NOT NULL,
    CONSTRAINT PK_ARTISTMGREXPENSE_T PRIMARY KEY (ExpenseID));
    
CREATE TABLE CONTRACT_T
  ( ContractID		BIGINT(12)    NOT NULL,
    StartDate		  DATE     NOT NULL,
    EndDate		    DATE     NOT NULL,
    RoyaltyPerc		NUMERIC(4,2)   NOT NULL,
    Terms		      LONGTEXT                  ,
    ArtistID		  BIGINT(12)    NOT NULL,
    CONSTRAINT PK_CONTRACT_T PRIMARY KEY (ContractID));

CREATE TABLE CONTRACTEDARTIST_T
  ( ArtistID      BIGINT(12)    NOT NULL,
    AManagerID    BIGINT(12)    NOT NULL,
    CONSTRAINT PK_CONTRACTEDARTIST_T PRIMARY KEY (ArtistID));

CREATE TABLE CUSTOMER_T
  ( CustomerID    BIGINT(12)     NOT NULL,
    CustomerName  VARCHAR(100)    NOT NULL,
    Street        VARCHAR(40),
    City          VARCHAR(30),
    State         VARCHAR(2),
    Zip           VARCHAR(9),
    Phone         CHAR(10)       NOT NULL,
    Email         VARCHAR(50)   NOT NULL,
    CONSTRAINT PK_CUSTOMER_T PRIMARY KEY (CustomerID));
    
CREATE TABLE CUSTOMERPAYMENT_T
  ( CPaymentID    BIGINT(12)      NOT NULL,
    CPaymentDate  DATE       NOT NULL,
    Amount        NUMERIC(12,2)    NOT NULL,
    CustomerID    BIGINT(12)      NOT NULL,
    CONSTRAINT PK_CUSTOMERPAYMENT_T PRIMARY KEY (CPaymentID));
    
CREATE TABLE DEGREE_T
  ( DegreeID      BIGINT(12)      NOT NULL,
    DegreeName    VARCHAR(100)    NOT NULL,
    University    VARCHAR(50)     NOT NULL,
    CONSTRAINT PK_DEGREE_T PRIMARY KEY (DegreeID));
    
CREATE TABLE EVENT_T
  ( EventID		    BIGINT(12)      NOT NULL,
    EventDesc 		VARCHAR(400)    NOT NULL,
    DateTime		DATE       NOT NULL,
    VenueID		    BIGINT(12)      NOT NULL,
    CustomerID		BIGINT(12)      NOT NULL,
    CONSTRAINT PK_EVENT_T PRIMARY KEY (EventID));

CREATE TABLE EXPENSE_T
  ( ExpenseID		  BIGINT(12)      NOT NULL,
    Description		VARCHAR(400)   NOT NULL,
    Amount		    NUMERIC(12,2)    NOT NULL,
    AccountNbr		BIGINT(16)      NOT NULL,
    ExpenseType		CHAR(1)         NOT NULL,
    CONSTRAINT CH_ExpenseType CHECK
      (ExpenseType IN ('A','M')),
    CONSTRAINT PK_EXPENSE_T PRIMARY KEY (ExpenseID));
    
CREATE TABLE HONOR_T
  ( HonorID       BIGINT(12)      NOT NULL,
    HonorDesc     VARCHAR(100)   NOT NULL,
    CONSTRAINT PK_HONOR_T PRIMARY KEY (HonorID));

CREATE TABLE INSTRUMENT_T
  ( InstrumentID    BIGINT(12)    NOT NULL,
    InstrumentName  VARCHAR(50)  NOT NULL,
    CONSTRAINT PK_INSTRUMENT_T PRIMARY KEY (InstrumentID));

CREATE TABLE INVOICE_T
  ( InvoiceNbr      BIGINT(12)    NOT NULL,
    InvoiceDate     DATE     NOT NULL,
    Total           NUMERIC(12,2)  NOT NULL,
    CONSTRAINT PK_INVOICE_T PRIMARY KEY (InvoiceNbr));

CREATE TABLE AGREEMENTINVOICE_T
  ( AgreementNbr    BIGINT(12)    NOT NULL,
    InvoiceNbr      BIGINT(12)    NOT NULL,
    Amount          NUMERIC(12,2)  NOT NULL,
    CONSTRAINT PK_AGREEMENTINVOICE_T PRIMARY KEY (AgreementNbr,InvoiceNbr));
    
CREATE TABLE INVOICEPAYMENT_T
  ( InvoiceNbr      BIGINT(12)    NOT NULL,
    CPaymentID       BIGINT(12)    NOT NULL,
    Amount          NUMERIC(12,2)  NOT NULL,
    CONSTRAINT PK_INVOICEPAYMENT_T PRIMARY KEY (InvoiceNbr, CPaymentID));

CREATE TABLE NEWSITEM_T
  ( NewsItemID      BIGINT(12)      NOT NULL,
    NewsItemSource  VARCHAR(100)   NOT NULL,
    NewsItemDate    DATE       NOT NULL,
    NewsItemSummary VARCHAR(4000)  NOT NULL,
    NewsItemContent VARCHAR(4000),            
    CONSTRAINT PK_NEWSITEM_T PRIMARY KEY (NewsItemID));
    
CREATE TABLE PERSONALC_T
  ( ACommitmentID   BIGINT(12)    NOT NULL,
    Firmness        CHAR(1)       NOT NULL,
    CONSTRAINT CH_Firmness CHECK (Firmness IN ('F','N')),
    CONSTRAINT PK_PERSONALC_T PRIMARY KEY (ACommitmentID));

CREATE TABLE PERFORMANCERELATEDC_T
  ( ACommitmentID     BIGINT(12)    NOT NULL,
    PRCCategory       CHAR(1)       NOT NULL,
    EventID           BIGINT(12)    NOT NULL,
    CONSTRAINT CH_PRCCategory CHECK (PRCCategory IN ('P','R','T')),
    CONSTRAINT PK_PERFORMANCERELATED_T PRIMARY KEY (ACommitmentID));
    
CREATE TABLE PROSPECTIVEARTIST_T
  ( ArtistID          BIGINT(12)    NOT NULL,
    CONSTRAINT PK_PROSPECTIVEARTIST_T PRIMARY KEY (ArtistID));
   
CREATE TABLE RECOMMENDATION_T
  ( RecommendationID		BIGINT(12)      NOT NULL,
    RecSummary		      VARCHAR(1000)  NOT NULL,
    QualityEvaluation		VARCHAR(500)   NOT NULL,
    ReceivedDate		    DATE       NOT NULL,
    CreatedDate		      DATE       NOT NULL,
    ArtistID		        BIGINT(12)      NOT NULL,
    SourceID		        BIGINT(12)      NOT NULL,
    CONSTRAINT PK_RECOMMENDATION_T PRIMARY KEY (RecommendationID));

CREATE TABLE SAMPLE_T
  ( SampleID      BIGINT(12)    NOT NULL,
    SampleContent VARCHAR(4000) NOT NULL,
    ArtistID      BIGINT(12)    NOT NULL,
    CONSTRAINT PK_SAMPLE_T PRIMARY KEY (SampleID));
    
CREATE TABLE SOURCE_T
  ( SourceID		  BIGINT(12)    NOT NULL,
    SourceName		VARCHAR(50)  NOT NULL,
    SourceType		VARCHAR(20)  NOT NULL,
    Quality		    NUMERIC(2,0)   NOT NULL,
    CONSTRAINT CH_SOURCE_Quality CHECK
      (Quality BETWEEN 0 AND 10),
    CONSTRAINT PK_SOURCE_T PRIMARY KEY (SourceID));

CREATE TABLE VENUE_T
  ( VenueID       BIGINT(12)    NOT NULL,
    VenueName     VARCHAR(50)  NOT NULL,
    Street        VARCHAR(40),
    City          VARCHAR(30),
    State         VARCHAR(2),
    Zip           VARCHAR(9),
    Phone         CHAR(10)       NOT NULL,
    Country       VARCHAR(50),
    CONSTRAINT PK_VENUE_T PRIMARY KEY (VenueID));
 
ALTER TABLE ADMIN_T
  ADD CONSTRAINT FK_ADMIN_AManagerID FOREIGN KEY (AManagerID)
    REFERENCES ARTISTMANAGER_T (AManagerID);
    
ALTER TABLE AGREEMENT_T
  ADD CONSTRAINT FK_AGREEMENT_EventID FOREIGN KEY (EventID)
    REFERENCES EVENT_T (EventID);
ALTER TABLE AGREEMENT_T
  ADD CONSTRAINT FK_AGREEMENT_ContractID FOREIGN KEY (ContractID)
    REFERENCES CONTRACT_T (ContractID);

ALTER TABLE ARTISTCOMMITMENT_T
  ADD CONSTRAINT FK_ARTISTCOMMITMENT_ArtistID FOREIGN KEY (ArtistID)
    REFERENCES CONTRACTEDARTIST_T (ArtistID);
    
ALTER TABLE ARTISTDEGREE_T
  ADD CONSTRAINT FK_ARTISTDEGREE_ArtistID FOREIGN KEY (ArtistID)
    REFERENCES ARTIST_T (ArtistID);
ALTER TABLE ARTISTDEGREE_T
  ADD CONSTRAINT FK_ARTISTDEGREE_DegreeID FOREIGN KEY (DegreeID)
    REFERENCES DEGREE_T (DegreeID);
    
ALTER TABLE ARTISTEXPENSE_T
  ADD CONSTRAINT FK_ARTISTEXPENSE_ArtistID FOREIGN KEY (ArtistID)
    REFERENCES CONTRACTEDARTIST_T (ArtistID);
ALTER TABLE ARTISTEXPENSE_T
  ADD CONSTRAINT FK_ARTISTEXPENSE_ExpenseID FOREIGN KEY (ExpenseID)
    REFERENCES EXPENSE_T (ExpenseID);
    
ALTER TABLE ARTISTHONOR_T
  ADD CONSTRAINT FK_ARTISTHONOR_ArtistID FOREIGN KEY (ArtistID)
    REFERENCES ARTIST_T (ArtistID);
ALTER TABLE ARTISTHONOR_T
  ADD CONSTRAINT FK_ARTISTHONOR_HonorID FOREIGN KEY (HonorID)
    REFERENCES HONOR_T (HonorID);

ALTER TABLE ARTISTINSTRUMENT_T
  ADD CONSTRAINT FK_ARTISTINSTRUMENT_ArtistID FOREIGN KEY (ArtistID)
    REFERENCES ARTIST_T (ArtistID);
ALTER TABLE ARTISTINSTRUMENT_T    
  ADD CONSTRAINT FK_ARTISTINSTRUMENT_InstrID FOREIGN KEY (InstrumentID)
    REFERENCES INSTRUMENT_T (InstrumentID);

ALTER TABLE ARTISTNEWS_T
  ADD CONSTRAINT FK_ARTISTNEWS_ArtistID FOREIGN KEY (ArtistID)
    REFERENCES ARTIST_T (ArtistID);
ALTER TABLE ARTISTNEWS_T
  ADD CONSTRAINT FK_ARTISTNEWS_NewsItemID FOREIGN KEY (NewsItemID)
    REFERENCES NEWSITEM_T (NewsItemID);
    
ALTER TABLE ARTISTPAYMENT_T
  ADD CONSTRAINT FK_ARTISTPAYMENT_ArtistID FOREIGN KEY (ArtistID)
    REFERENCES CONTRACTEDARTIST_T (ArtistID);
ALTER TABLE ARTISTPAYMENT_T
  ADD CONSTRAINT FK_ARTISTPAYMENT_AdminID FOREIGN KEY (AdminID)
    REFERENCES ADMIN_T (AdminID);
    
ALTER TABLE ARTISTMGREXPENSE_T
  ADD CONSTRAINT FK_ARTISTMGREXPENSE_AManagerID FOREIGN KEY (AManagerID)
    REFERENCES ARTISTMANAGER_T (AManagerID);
ALTER TABLE ARTISTMGREXPENSE_T
  ADD CONSTRAINT FK_ARTISMGRTEXPENSE_ExpenseID FOREIGN KEY (ExpenseID)
    REFERENCES EXPENSE_T (ExpenseID);
    
ALTER TABLE CONTRACT_T
  ADD CONSTRAINT FK_CONTRACT_ArtistID FOREIGN KEY (ArtistID)
    REFERENCES CONTRACTEDARTIST_T (ArtistID);
    
ALTER TABLE CONTRACTEDARTIST_T
  ADD CONSTRAINT FK_CONTRACTEDARTIST_ArtistID FOREIGN KEY (ArtistID)
    REFERENCES ARTIST_T (ArtistID);
ALTER TABLE CONTRACTEDARTIST_T
  ADD CONSTRAINT FK_CONTRACTEDARTIST_AManagerID FOREIGN KEY (AManagerID)
    REFERENCES ARTISTMANAGER_T (AManagerID);

ALTER TABLE CUSTOMERPAYMENT_T
  ADD CONSTRAINT FK_CUSTOMERPAYMENT_CustomerID FOREIGN KEY (CustomerID)
    REFERENCES CUSTOMER_T (CustomerID);
    
ALTER TABLE EVENT_T
  ADD CONSTRAINT FK_EVENT_VenueID FOREIGN KEY (VenueID)
    REFERENCES VENUE_T (VenueID);
ALTER TABLE EVENT_T  
  ADD CONSTRAINT FK_EVENT_CustomerID FOREIGN KEY (CustomerID)
    REFERENCES CUSTOMER_T (CustomerID);

ALTER TABLE INVOICEPAYMENT_T
  ADD CONSTRAINT FK_INVOICEPAYMENT_InvoiceNbr FOREIGN KEY (InvoiceNbr)
    REFERENCES INVOICE_T (InvoiceNbr);
ALTER TABLE INVOICEPAYMENT_T
  ADD CONSTRAINT FK_INVOICEPAYMENT_CPaymentID FOREIGN KEY (CPaymentID)
    REFERENCES CUSTOMERPAYMENT_T (CPaymentID);

ALTER TABLE AGREEMENTINVOICE_T
  ADD CONSTRAINT FK_AGREEMENTINVOICE_InvNbr FOREIGN KEY (InvoiceNbr)
    REFERENCES INVOICE_T (InvoiceNbr);
ALTER TABLE AGREEMENTINVOICE_T
  ADD CONSTRAINT FK_AGREEMENTINVOICE_AgrID FOREIGN KEY (AgreementNbr)
    REFERENCES AGREEMENT_T (AgreementNbr);
    
ALTER TABLE PERSONALC_T
  ADD CONSTRAINT FK_PERSONALC_ACommitmentID FOREIGN KEY (ACommitmentID)
    REFERENCES ARTISTCOMMITMENT_T (ACommitmentID);

ALTER TABLE PERFORMANCERELATEDC_T
  ADD CONSTRAINT FK_PERFRELATEDC_ACommitmentID FOREIGN KEY (ACommitmentID)
    REFERENCES ARTISTCOMMITMENT_T (ACommitmentID);
ALTER TABLE PERFORMANCERELATEDC_T
  ADD CONSTRAINT FK_PERFRELATEDC_EventID FOREIGN KEY (EventID)
    REFERENCES EVENT_T (EventID);

/*
 ALTER TABLE PROSPECTIVEARTIST_T
  ADD CONSTRAINT FK_PROSPARTIST_ArtistID FOREIGN KEY (ArtistID)
    REFERENCES PROSPECTIVEARTIST_T (ArtistID);
*/
    
ALTER TABLE RECOMMENDATION_T
  ADD CONSTRAINT FK_RECOMMENDATION_ArtistID FOREIGN KEY (ArtistID)
    REFERENCES PROSPECTIVEARTIST_T (ArtistID);
ALTER TABLE RECOMMENDATION_T
  ADD CONSTRAINT FK_RECOMMENDATION_SourceID FOREIGN KEY (SourceID)
    REFERENCES SOURCE_T (SourceID);
