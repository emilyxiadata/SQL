use mydb_lxia;

# 6-92a
select AgreementNbr, AgreementDate, GrossAmount from AGREEMENT_T 
where GrossAmount >= 1500 and GrossAmount<=2000;

# 6-92b
select CustomerID, CustomerName from CUSTOMER_T where CustomerName like '%Arts%';

# 6-92c
select ArtistID, LastName, FirstName, YearOfBirth, ArtistType from ARTIST_T
where Gender = 'F' and State in ('PA', 'NJ');

# 6-92d
select ArtistID, StartDate, EndDate, RoyaltyPerc from CONTRACT_T
where RoyaltyPerc >= 20.00 and EndDate>curdate()
order by ArtistID ASC;

# 6-92e
select sum(Amount) from CUSTOMERPAYMENT_T
where CPaymentDate between '2015-02-01' and '2015-03-31';

# 6-92f
select ArtistID from ARTISTPAYMENT_T
where APaymentDate between '2015-01-01' and '2015-03-31'
group by ArtistID having sum(Amount) >= 2000;

# 6-92g
select VenueID, count(EventID) as 'number of events' from EVENT_T group by VenueID;

# 6-92h
select VenueID, count(EventID) as 'number of events' from EVENT_T group by VenueID
having count(EventID) >= 2;

# 6-92i
select ExpenseID, Description, Amount, ExpenseType from EXPENSE_T
where (Amount <100 and ExpenseType = 'M') or (Amount <50 and ExpenseType = 'A');

# 7-77a
select distinct ARTIST_T.ArtistID, concat(FirstName,' ',LastName) as FullName, YearOfBirth, RoyaltyPerc 
from ARTIST_T join CONTRACT_T on ARTIST_T.ArtistID = CONTRACT_T.ArtistID
where EndDate>=curdate();

# 7-77b
select distinct EVENT_T.EventID, EventDesc, DateTime
from EVENT_T
join AGREEMENT_T on EVENT_T.EventID = AGREEMENT_T.EventID
join CONTRACT_T on CONTRACT_T.ContractID = AGREEMENT_T.ContractID
join ARTIST_T on CONTRACT_T.ArtistID = ARTIST_T.ArtistID
where FirstName = 'Juan' and LastName = 'Becker';

# 7-77c
select concat(FirstName,' ',LastName) as ArtistName, EVENT_T.EventID, EventDesc,
DateTime, GrossAmount
from AGREEMENT_T
join EVENT_T on AGREEMENT_T.EventID = EVENT_T.EventID 
join CONTRACT_T on AGREEMENT_T.ContractID = CONTRACT_T.ContractID
join CONTRACTEDARTIST_T on CONTRACT_T.ArtistID = CONTRACTEDARTIST_T.ArtistID
join ARTIST_T on CONTRACTEDARTIST_T.ArtistID = ARTIST_T.ArtistID
where AManagerID = '1' and DateTime between '2014-12-01' and '2015-1-31';

# 7-77d
select EVENT_T.EventID, EventDesc, DateTime, 
	   GrossAmount*(1 - RoyaltyPerc/100) AS ArtistShare,
       0.5 * GrossAmount *RoyaltyPerc/100 AS ManagerShare, 
       0.5 * GrossAmount *RoyaltyPerc/100 AS FAMEShare
from AGREEMENT_T
join EVENT_T on AGREEMENT_T.EventID = EVENT_T.EventID 
join CONTRACT_T on AGREEMENT_T.ContractID = CONTRACT_T.ContractID
join CONTRACTEDARTIST_T on CONTRACT_T.ArtistID = CONTRACTEDARTIST_T.ArtistID
join ARTIST_T on CONTRACTEDARTIST_T.ArtistID = ARTIST_T.ArtistID
where AManagerID = '1' and DateTime between '2014-12-01' and '2015-1-31';

# 7-77e
select EVENT_T.EventID, EventDesc, DateTime, GrossAmount, GrossAmount*(1 - RoyaltyPerc/100) as ArtistShare
from AGREEMENT_T
join EVENT_T on AGREEMENT_T.EventID = EVENT_T.EventID 
join CONTRACT_T on AGREEMENT_T.ContractID = CONTRACT_T.ContractID
join CONTRACTEDARTIST_T on CONTRACT_T.ArtistID = CONTRACTEDARTIST_T.ArtistID
join ARTIST_T on CONTRACTEDARTIST_T.ArtistID = ARTIST_T.ArtistID
where FirstName = 'Juan' and LastName = 'Becker'
and DateTime between '2014-12-01' and '2015-03-31';

# 7-77f
SELECT concat(FirstName, " ", LastName) as Artist_Name, CommitmentType, ARTISTCOMMITMENT_T.ACommitmentID, PRCCategory, EventDesc, StartDateTime, EndDateTime FROM
ARTIST_T JOIN ARTISTCOMMITMENT_T ON ARTIST_T.ArtistID = ARTISTCOMMITMENT_T.ArtistID
LEFT OUTER JOIN PERSONALC_T ON ARTISTCOMMITMENT_T.ACommitmentID = PERSONALC_T.ACommitmentID
LEFT OUTER JOIN PERFORMANCERELATEDC_T ON ARTISTCOMMITMENT_T.ACommitmentID = PERFORMANCERELATEDC_T.ACommitmentID
LEFT OUTER JOIN EVENT_T ON PERFORMANCERELATEDC_T.EventID = EVENT_T.EventID
WHERE ARTIST_T.FirstName = 'Pat' AND ARTIST_T.LastName = 'Jiminez' AND
((STR_TO_DATE(StartDateTime, '%e-%b-%Y %h:%i:%s.%f %p') between '2014-12-01' AND '2014-12-31')
AND (STR_TO_DATE(EndDateTime, '%e-%b-%Y %h:%i:%s.%f %p') between '2014-12-01' AND '2014-12-31'));
