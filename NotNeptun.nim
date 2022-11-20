import fidget
include ./db

loadFont("IBM Plex Sans", "IBMPlexSans-Regular.ttf")
loadFont("IBM Plex Sans Bold", "IBMPlexSans-Bold.ttf")

var
  selectedTab = ""

proc viewHallgatok() =
  frame "textLayout":
    counterAxisSizingMode csFixed

    var 
      datas:seq[ (int, string, string, string) ] = listHallgato()
      s:string = ""
    text "text":
      box 300, 40 , 600, 600
      fill "#000000"
      constraints cCenter, cCenter
      font "IBM Plex Sans", 24, 400, 0, hCenter, vTop
      s.add "ID\tVezetéknév\tKeresztnév\tSzak\n"
      for x in datas:
        s.add( ($x[0] & "\t" & $x[1] & "\t \t" & $x[2] & "\t \t" & $x[3] & "\n") )
      characters s
      textAutoResize tsHeight
      layoutAlign laStretch
    rectangle "view":
      counterAxisSizingMode csAuto
      box 315, 27, 674, 715
      fill "#d6d6d6"

proc viewKurzusok() =
  frame "textLayout":
    counterAxisSizingMode csFixed

    var 
      datas:seq[ ( string, string, string) ] = listKurzusok()
      s:string = ""
    text "text":
      box 320, 40 , 600, 600
      fill "#000000"
      font "IBM Plex Sans", 24, 400, 0, hLeft, vTop
      s.add "Név\t \tIdőpont\t \tKód\n"
      for x in datas:
        s.add( ($x[0] & "\t" & $x[1] & "\t" & $x[2] & "\n") )
      characters s
      textAutoResize tsHeight
      layoutAlign laStretch
    rectangle "view":
      counterAxisSizingMode csAuto
      box 315, 27, 674, 715
      fill "#d6d6d6"

proc viewTermek() =
  frame "textLayout":
    counterAxisSizingMode csFixed

    var 
      datas:seq[ ( string, int, string) ] = listTermek()
      s:string = ""
    text "text":
      box 320, 40 , 600, 600
      fill "#000000"
      font "IBM Plex Sans", 24, 400, 0, hLeft, vTop
      s.add "Név\t \t \tFerőhely\t \tÉpület\n"
      for x in datas:
        s.add( ($x[0] & "\t" & $x[1] & "\t \t" & $x[2] & "\n") )
      characters s
      textAutoResize tsHeight
      layoutAlign laStretch
    rectangle "view":
      counterAxisSizingMode csAuto
      box 315, 27, 674, 715
      fill "#d6d6d6"

proc insertData() =
  return


proc drawMain() = 
    frame "NotNeptun":
      counterAxisSizingMode csAuto
      setTitle "NotNeptun"
      orgBox 0, 0, 1024, 768
      box root.box
      fill "#525252"

      for i, tabName in ["Hallgatók", "Kurzusok", "Termek", "Épület"]:
        group "tabs":
          counterAxisSizingMode csAuto
          box 43, (50 + (i*70) ) , 229, 45
          fill "#6d6d6d"
          layoutAlign laCenter
          onHover:
            fill "#9F9EB2"
          onClick:
            selectedTab = tabName
          text "text":
            box 15, 10 , 190, 30
            fill "#000000"
            constraints cCenter, cCenter
            font "IBM Plex Sans", 24, 400, 0, hCenter, vCenter
            characters tabName
      rectangle "menu":
          counterAxisSizingMode csAuto
          box 26, 27, 261, 715
          fill "#d9d9d9"
      
      case selectedTab:
        of "Hallgatók":
          viewHallgatok()
        of "Kurzusok":
          viewKurzusok()
        of "Termek":
          viewTermek()
          let a = 2;
        of "Épületek":
          let a = 2;

startFidget(drawMain, w=1024, h=768 )