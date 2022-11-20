import std / [db_mysql, strutils]

proc setup() =
    let db = open("localhost","postgres","","users")

    db.exec(sql("DROP TABLE IF EXISTS users"))
    db.exec(sql("""CREATE TABLE users (
                          id SERIAL PRIMARY KEY, 
                          name varchar(50))"""))
    db.close()
    echo "Database created!"
    return

#[
  Return with an array of tuples that 
  contain every data about a specific field
]#
proc listHallgato(): seq[ (int, string, string, string) ] =
  let 
    db = open("localhost","root","","etr")
  if (setEncoding(db, "utf8") == false ):
    return
  var 
    arr: seq[ (int, string, string, string) ] = @[]

  for x in db.rows( sql("SELECT * FROM hallgato")):
    arr.add ( parseInt x[0] , x[1], x[2], x[3] )
  db.close()

  return arr

proc listTermek(): seq[ (string, int, string) ] =
  let 
    db = open("localhost","root","","etr")
  if (setEncoding(db, "utf8") == false ):
    return
  var 
    arr: seq[ (string, int, string) ] = @[]

  for x in db.rows( sql("SELECT * FROM terem")):
    arr.add ( x[0], parseInt x[1], x[2] )
  db.close()

  return arr

proc listKurzusok(): seq[ (string, string, string) ] =
  let db = open("localhost","root","","etr")
  if (setEncoding(db, "utf8") == false ):
    return
  var 
    arr: seq[ (string, string, string) ] = @[]

  for x in db.rows( sql("SELECT * FROM kurzus")):
    arr.add ( x[0], x[1], x[2] )
  db.close()

  return arr

proc listEpulet(): seq[ (string, string, string) ] =
  let db = open("localhost","root","","etr")
  if (setEncoding(db, "utf8") == false ):
    return
  var 
    arr: seq[ (string, string, string) ] = @[]

  for x in db.rows( sql("SELECT * FROM epulet")):
    arr.add ( x[0], x[1], x[2] )
  db.close()

  return arr

proc insertData( name: string ) =
    let db = open("localhost","postgres","","users")

    db.exec(sql("INSERT INTO users (name) VALUES ('" & $name & "')"))

    echo "Data inserted!"
    db.close()
    return