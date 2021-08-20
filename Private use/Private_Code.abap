
REPORT z_071_tutorial_ch3.

**********************************************************************
* Declaring Data Using Predefined Data Types
**********************************************************************

* Date and Time
DATA: date TYPE d,
      time TYPE t.

* Numeric
DATA: whole_number  TYPE i,
      float_number  TYPE f,
      packed_number TYPE p DECIMALS 2.

* Character
DATA: character     TYPE c,
      textc(40)     TYPE c,                                 "LENGTH 40,
      texts         TYPE string, "length varies according to content
      numerical_txt TYPE n.

* Structure
DATA: BEGIN OF str_students,
        name(10) TYPE c,
        id(4)    TYPE n,
      END OF str_students.

* Internal Table, type STANDARD (opposite to SORTED, HASHED)
DATA: table_students LIKE TABLE OF str_students.   "LIKE instead of TYPE as str_students is data object, not type

* Own Data Type (Local)
TYPES: text10 TYPE c LENGTH 10.
DATA:  text   TYPE text10.

**********************************************************************
* Data manipulation
**********************************************************************

** Calculation Instructions
ADD 10 TO whole_number.
MULTIPLY whole_number BY 2.
DIVIDE whole_number BY 4.
SUBTRACT 3 FROM whole_number.
WRITE: /'1.A. result: ', whole_number.

whole_number = whole_number + 10.
whole_number = whole_number * 2.
whole_number = whole_number / 4.
whole_number = whole_number - 3.
WRITE: /'1.B. result: ', whole_number.

** Deleting Content of Variable
CLEAR whole_number.
WRITE: /'2. result: ', whole_number.

** Calculation Expression
COMPUTE whole_number = 10 * 2 / 3 - 4.
whole_number = 10 * 2 / 3 - 4.
WRITE: /'3.A. whole-number result: ', whole_number.
packed_number = 10 * 2 / 3 - 4.
WRITE: /'3.B. packed-number result: ', packed_number.
float_number = 10 * 2 / 3 - 4.
WRITE: /'3.C. float-number result: ', float_number.

** Passing Value
MOVE 5       TO whole_number.
MOVE 'HELLO' TO textc.
MOVE 'BBA'   TO texts.

** String operation (CONCATENATE, TRANSLATE, SPLIT, REPLACE ... )
CONCATENATE textc texts INTO texts SEPARATED BY space.
WRITE: /,/'value of texts after concatenate: ', texts.
TRANSLATE   texts TO LOWER CASE.
WRITE: /'value of texts after translate: ', texts.
SPLIT       texts AT space INTO textc texts.
WRITE: /'value of textc, texts after split: ', textc, ', ', texts.

** date and time operations
date = sy-datum.
date = date + 2.                  " Adding days to the date
WRITE: /,/'4.A date:', date.
date = 20160227.                  " has to be a string
WRITE: /'4.B date:', date.
date = '20160235'.                " the value is not checked
WRITE: /'4.C date:', date.
time = sy-uzeit.
WRITE: /,/'5.A time:', time.
time = time + 3600.               " Adding secondes to the time
WRITE: /'5.B time:', time.
time = '250204'.                  " the value is not checked
WRITE: /'5.C time:', time.
time+2(4) = '0000'.               " Masking the time
WRITE: /'5.D time:', time.

* Performing loops
WRITE /.
DO 3 TIMES.
  time = sy-uzeit.
  WRITE: /'6. loop-time:', time.
ENDDO.

WHILE whole_number > 0.
  WRITE: /'7. loop value of whole_number:', whole_number.
  whole_number = whole_number - 1.
ENDWHILE.

** branching IF-statement
WRITE /.
IF textc CS 'AL'.
  WRITE / 'textc contains AL'.
ELSEIF textc CS 'EL'.
  WRITE / 'textc contains EL and not AL'.
ELSE.
  WRITE / 'textc contains not EL and not AL'.
endif.

** Structure and table manipulation,INSERT to fill internal table (APPEND for standard tables)
** READ, DELETE, MODIFY statements available
  MOVE 'Pinar' TO str_students-name.
  MOVE  1900   TO str_students-id.
  APPEND str_students TO table_students.

  MOVE 'Sai' TO str_students-name.
  MOVE 1100  TO str_students-id.
  APPEND str_students TO table_students.

  MOVE 'Jörn5678912345' TO str_students-name.
  MOVE 2100   TO str_students-id.
  APPEND str_students TO table_students.

** Access to the internal table with LOOP AT .. INTO wa
** Sorting with SORT ... ASCENDING BY ..
  WRITE: /, /'Following data content of the table:'.
  NEW-LINE.
  LOOP AT table_students INTO str_students.
    WRITE: str_students-name, str_students-id.
    NEW-LINE.
  ENDLOOP.

  SORT table_students ASCENDING BY id.
  WRITE /'Following data content of the table after sorting:'.
  NEW-LINE.
  LOOP AT table_students INTO str_students.
    WRITE: str_students-name, str_students-id.
    NEW-LINE.
  ENDLOOP.
