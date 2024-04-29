with Code as
(
    Select * from {{ref('CountryCode')}}
    union
    Select * from {{ref('CountryCode2')}}

)
select * from Code