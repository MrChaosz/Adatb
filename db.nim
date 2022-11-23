import std / [db_mysql, strutils, random]

# connection info of the database
var
  dbHost = ""
  userName = ""
  dbPassw = ""
  dbName = ""

#[
  Return with an array of tuples that 
  contain every data about a specific field
]#
proc listHallgato(): seq[ (string, string, string, string) ] =
  let 
    db = open(dbHost,userName,dbPassw,dbName)
  if (setEncoding(db, "utf8") == false ):
    return
  var 
    arr: seq[ (string, string, string, string) ] = @[]

  for x in db.rows( sql("SELECT * FROM hallgato;")):
    arr.add ( x[0] , x[1], x[2], x[3] )
  db.close()

  return arr

proc listTermek(): seq[ (string, int, string) ] =
  let 
    db = open(dbHost,userName,dbPassw,dbName)
  if (setEncoding(db, "utf8") == false ):
    return
  var 
    arr: seq[ (string, int, string) ] = @[]

  for x in db.rows( sql("SELECT * FROM terem;")):
    arr.add ( x[0], parseInt x[1], x[2] )
  db.close()

  return arr

proc listKurzusok(): seq[ (string, string, string) ] =
  let db = open(dbHost,userName,dbPassw,dbName)
  if (setEncoding(db, "utf8") == false ):
    return
  var 
    arr: seq[ (string, string, string) ] = @[]

  for x in db.rows( sql("SELECT * FROM kurzus;")):
    arr.add ( x[0], x[1], x[2] )
  db.close()

  return arr

proc listEpulet(): seq[ (string, string, string) ] =
  let db = open(dbHost,userName,dbPassw,dbName)
  if (setEncoding(db, "utf8") == false ):
    return
  var 
    arr: seq[ (string, string, string) ] = @[]

  for x in db.rows( sql("SELECT * FROM epulet;")):
    arr.add ( x[0], x[1], x[2] )
  db.close()

  return arr

proc listOktato(): seq[ (string, string, string, string, string) ] =
  let 
    db = open(dbHost,userName,dbPassw,dbName)
  if (setEncoding(db, "utf8") == false ):
    return
  var 
    arr: seq[ (string, string, string, string, string) ] = @[]

  for x in db.rows( sql("SELECT * FROM oktato;")):
    arr.add ( x[0], x[1], x[2], x[3], x[4])
  db.close()

  return arr

proc getTableNames(): seq[string] =
  let db = open(dbHost,userName,dbPassw,dbName)
  if (setEncoding(db, "utf8") == false ):
    return
  var
    names:seq[string]

  for x in db.rows( sql("SHOW TABLES FROM etr;")):
    names.add(x)

  db.close()
  return names

proc getColumnsTable(table:string): seq[string] =
  let db = open(dbHost,userName,dbPassw,dbName)
  if (setEncoding(db, "utf8") == false ):
    return
  var
    names:seq[string]

  for x in db.rows( sql("SHOW COLUMNS FROM " & $table & " IN etr;")):
    names.add(x[0])

  db.close()
  return names

proc insertData( tableName: string, values:seq[string] ) =
  let db = open(dbHost,userName,dbPassw,dbName)
  if (setEncoding(db, "utf8") == false ):
    return

  var
    strings:seq[string] = @[]
    insert:string
    kod:string

  case tableName:
    of "epulet":
      for x in values:
        strings.add(x)
      insert = "(" & "'" & $strings[0] & "'" & "," & "'" & $strings[1] & "'" & "," & "'" & $strings[2] & "'" & ")"
      db.exec(sql("INSERT INTO epulet VALUES " & insert & ";"))
    of "hallgato":
      for x in values:
        strings.add(x)
      randomize()
      kod.add strings[1][0] & strings[2][0] & $(getColumnsTable("hallgato").len()) & $rand(999)
      insert = "(" & "'" & kod & "'" & "," & "'" & $strings[1] & "'" & "," & "'" & $strings[2] & "'" & "," & "'" & $strings[3] & "'" & ")"
      db.exec(sql("INSERT INTO hallgato (kod, vezeteknev, keresztnev, szak) VALUES "& insert & ";" ))
    of "kurzus":
      for x in values:
        strings.add(x)
      insert = "(" & "'" & $strings[0] & "'" & "," & "'" & $strings[1] & "'" & "," & "'" & $strings[2] & "'" & ")"
      db.exec(sql("INSERT INTO kurzus VALUES " & insert & ";"))
    of "oktato":
      for x in values:
        strings.add(x)
      randomize()
      kod.add strings[1][0] & strings[2][0] & $(getColumnsTable("hallgato").len()) & $rand(999)
      insert = "( " & "'" & kod & "'" & "," & "'" & $strings[1] & "'" & "," & "'" & $strings[2] & "'" & "," & "'" & $strings[3] & "'" & "," & "'" & $strings[4] & "'" & ")"
      db.exec(sql("INSERT INTO oktato (kod, vezeteknev, keresztnev, szak, kezdesEve) VALUES "& insert & ";" ))
    of "terem":
      for x in values:
        strings.add(x)
      insert = "(" & "'" & $strings[0] & "'" & "," & "'" & $strings[1] & "'" & "," & "'" & $strings[2] & "'" & ")"
      db.exec(sql("INSERT INTO terem VALUES " & insert & ";"))

  #echo "Data inserted!"
  db.close()
  return

proc deleteData( tableName:string, key:string) =
  let db = open(dbHost,userName,dbPassw,dbName)
  if (setEncoding(db, "utf8") == false ):
    return
  
  case tableName:
    of "hallgato":
      db.exec(sql("DELETE FROM hallgato WHERE hallgato.kod = '" & key & "';" ))
    of "epulet":
      db.exec(sql("DELETE FROM epulet WHERE epulet.nev = '" & key & "';" ))
    of "kurzus":
      db.exec(sql("DELETE FROM kurzus WHERE kurzus.nev = '" & key & "';" ))
    of "oktato":
      db.exec(sql("DELETE FROM oktato WHERE oktato.kod = '" & key & "';" ))
    of "terem":
      db.exec(sql("DELETE FROM terem WHERE terem.nev = '" & key & "';" ))
      
  db.close()
  return

proc searchKey( tableName:string, key:string ): string =
  let 
    db = open(dbHost,userName,dbPassw,dbName)
  if (setEncoding(db, "utf8") == false ):
    return
  var 
    result:string = ""

  case tableName:
    of "hallgato":
      for x in db.rows(sql("SELECT * FROM hallgato WHERE hallgato.kod = '" & $key & "';") ):
        result.add(x[0] & "\t" & x[1] & "\t" & x[2] & "\t" & x[3])
    of "epulet":
      for x in db.rows(sql("SELECT * FROM epulet WHERE epulet.nev = '" & $key & "';") ):
        result.add(x[0] & "\t" & x[1] & "\t" & x[2])
    of "kurzus":
      for x in db.rows(sql("SELECT * FROM kurzus WHERE kurzus.nev = '" & $key & "';") ):
        result.add(x[0] & "\t" & x[1] & "\t" & x[2])
    of "oktato":
      for x in db.rows(sql("SELECT * FROM oktato WHERE oktato.kod = '" & $key & "';") ):
        result.add(x[0] & "\t" & x[1] & "\t" & x[2] & "\t" & x[3] & "\t" & x[4])
    of "terem":
      for x in db.rows(sql("SELECT * FROM terem WHERE terem.nev = '" & $key & "';") ):
        result.add(x[0] & "\t" & x[1] & "\t" & x[2])

  db.close()
  return result

proc changeData( tableName:string, key:string, newData:seq[string]) =
  let db = open(dbHost,userName,dbPassw,dbName)
  if (setEncoding(db, "utf8") == false ):
    return

  var
    strings:seq[string] = @[]

  for x in newData:
    strings.add x

  case tableName:
    of "hallgato":
      db.exec(sql("UPDATE hallgato SET vezeteknev = '" & strings[1] & "', keresztnev = '" & strings[2] & "', szak = '" & strings[3] & "' WHERE kod = '" & key & "';" ))
    of "epulet":
      db.exec(sql("UPDATE epulet SET nev = '" & strings[1] & ", varos = " & strings[2] & ", utca = " & strings[3] & "' WHERE nev = '" & key & "';" ))
    of "kurzus":
      db.exec(sql("UPDATE kurzus SET nev = '" & strings[1] & ", idopont = '" & strings[2] & "', kod = '" & strings[3] & "' WHERE nev = '" & key & "'" ))
    of "oktato":
      db.exec(sql("UPDATE oktato SET vezeteknev = '" & strings[1] & "', keresztnev = '" & strings[2] & "',szak = '" & strings[3] & "', kezdesEve = '" & strings[4] & "' WHERE kod = '" & key & "';" ))
    of "terem":
      db.exec(sql("UPDATE terem SET nev = '" & strings[1] & "', ferohely = '" & strings[2] & "', epuletnev = " & strings[3] & " WHERE nev = '" & key & "';" ))

  db.close()
  return

proc dbConn( info:seq[string] ) =
  dbHost = info[0]
  userName = info[1]
  dbPassw = info[2]
  dbName = info[3]
    
  return
