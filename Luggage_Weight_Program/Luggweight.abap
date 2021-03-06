
REPORT z_071_luggweight.

*Creating a data structure of type flightweight
TYPES: BEGIN OF flightweight,
         carrier_id    TYPE sflight-carrid,
         connection_id TYPE sflight-connid,
         flight_date   TYPE sflight-fldate,
         plane_type    TYPE sflight-planetype,
         weight_sum    TYPE p DECIMALS 4,
       END OF flightweight.

DATA it_flight TYPE TABLE OF flightweight.
DATA wa_flight TYPE flightweight.

* Joining table flight and sbook
SELECT c~carrid
    c~connid
    c~fldate
    c~planetype
SUM( f~luggweight )
FROM sflight AS c
INNER JOIN sbook AS f
ON c~connid = f~connid AND c~carrid = f~carrid AND c~fldate = f~fldate
INTO TABLE it_flight
WHERE c~carrid = 'LH'
GROUP BY c~carrid c~connid c~fldate c~planetype.
SORT: it_flight BY plane_type ASCENDING flight_date ASCENDING.

*Looping through the internal table and printing out the output.
IF sy-subrc = 0 AND sy-dbcnt > 0.
  WRITE: / 'On the following flights we have so far calculated weight'.
  WRITE:/.
  LOOP AT it_flight INTO wa_flight.
    WRITE: / wa_flight-carrier_id, wa_flight-connection_id, wa_flight-flight_date, wa_flight-plane_type,
             wa_flight-weight_sum.
  ENDLOOP.
ENDIF.
