with Code as
(
    Select * from {{ref('CountryCode')}}
    

)
select * from Code