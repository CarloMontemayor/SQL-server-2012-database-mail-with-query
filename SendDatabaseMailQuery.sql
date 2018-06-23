-- This code was created by Carlo

-- create table
CREATE TABLE #SampleTable 
( 
  [ID]  [int],
  [Full Name]  [text],
  [Grade] [int],
  [Year]  [varchar](10)
)

-- insert some data
INSERT INTO #SampleTable
SELECT 1,'Juan Cruz',75,'3rd Year'
UNION ALL
SELECT 2,'Mang Pedro',65,'1st Year'
UNION ALL
SELECT 3,'Mang Juan Chicharon',98,'4th year'

-- declare query variable
DECLARE @html NVARCHAR(MAX)
DECLARE @body NVARCHAR(MAX)

-- call the html variable and then use the select query
SET @html = CAST(( SELECT [ID] AS 'td','',[Full Name] AS 'td','',
       [Grade] AS 'td','', Year AS 'td'
FROM  #SampleTable ORDER BY ID 
FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))

-- for html
SET @body ='<html><body><H3>Student Info</H3>
<table border = 1> 
<tr>
<th> ID </th> <th> Full Name </th> <th> Grade </th> <th> Year </th></tr>'    

 
SET @body = @body + @html +'</table></body></html>' -- body of the email with the query statement

-- Line for executing database mail
EXEC msdb.dbo.sp_send_dbmail
@profile_name = 'Profile Name', -- replace with your SQL Database Mail Profile 
@body = @body, -- body of the email
@body_format ='HTML', -- the body format
@recipients = 'Your Email', -- replace with your email address
@subject = 'Subject'; -- Subject for the email


DROP TABLE #SampleTable