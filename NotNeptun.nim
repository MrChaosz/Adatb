import fidget, std / [ sequtils ]
include ./db

loadFont("IBM Plex Sans", "IBMPlexSans-Regular.ttf")
loadFont("IBM Plex Sans Bold", "IBMPlexSans-Bold.ttf")

var
  selectedTab = ""
  dropDownOpen = false
  dropDownSelected = ""
  textInput:seq[string]
  singleInput:string
  ready:bool = false

# TODO: vonalak hogy egyértelműbbek legyenek a dolgok

proc viewHallgatok() =
  frame "textLayout":
    counterAxisSizingMode csFixed

    var 
      datas:seq[ (string, string, string, string) ] = listHallgato()
      s:string = ""
    text "text":
      box 320, 40 , 800, 600
      fill "#000000"
      font "IBM Plex Sans", 24, 400, 0, hLeft, vTop
      s.add "Kód\tVezetéknév\tKeresztnév\tSzak\n"
      for x in datas:
        s.add( ( $x[0] & "\t" & $x[1] & "\t \t" & $x[2] & "\t \t" & $x[3] & "\n") )
      characters s
      textAutoResize tsHeight
      layoutAlign laStretch
    rectangle "view":
      constraints cStretch, cMin
      counterAxisSizingMode csAuto
      box 315, 27, 950, 715
      fill "#d6d6d6"

proc viewKurzusok() =
  frame "textLayout":
    counterAxisSizingMode csFixed

    var 
      datas:seq[ ( string, string, string) ] = listKurzusok()
      s:string = ""
    text "text":
      box 320, 40 , 800, 600
      fill "#000000"
      font "IBM Plex Sans", 24, 400, 0, hLeft, vTop
      s.add "Név \t \t \tIdőpont\t \t \tKód\n"
      for x in datas:
        s.add( ($x[0] & " \t \t" & $x[1] & "\t \t" & $x[2] & "\n") )
      characters s
      textAutoResize tsHeight
      layoutAlign laStretch
    rectangle "view":
      constraints cStretch, cMin
      counterAxisSizingMode csAuto
      box 315, 27, 950, 715
      fill "#d6d6d6"

proc viewTermek() =
  frame "textLayout":
    counterAxisSizingMode csFixed

    var 
      datas:seq[ ( string, int, string) ] = listTermek()
      s:string = ""
    text "text":
      box 320, 40 , 800, 600
      fill "#000000"
      font "IBM Plex Sans", 24, 400, 0, hLeft, vTop
      s.add "Név\t \t \tFerőhely\t \tÉpület\n"
      for x in datas:
        s.add( ($x[0] & "\t" & $x[1] & "\t \t" & $x[2] & "\n") )
      characters s
      textAutoResize tsHeight
      layoutAlign laStretch
    rectangle "view":
      constraints cStretch, cMin
      counterAxisSizingMode csAuto
      box 315, 27, 950, 715
      fill "#d6d6d6"

proc viewEpuletek() = 
  frame "textLayout":
    counterAxisSizingMode csFixed

    var 
      datas:seq[ ( string, string, string) ] = listEpulet()
      s:string = ""
    text "text":
      box 320, 40 , 950, 600
      fill "#000000"
      font "IBM Plex Sans", 24, 400, 0, hLeft, vTop
      s.add "Név \t \t \tVáros\t \tUtca\n"
      for x in datas:
        s.add( ($x[0] & "\t \t \t" & $x[1] & "\t \t" & $x[2] & "\n") )
      characters s
      textAutoResize tsHeight
      layoutAlign laStretch
    rectangle "view":
      constraints cStretch, cMin
      counterAxisSizingMode csAuto
      box 315, 27, 950, 715
      fill "#d6d6d6"

proc viewOktatok() =
  frame "textLayout":
    counterAxisSizingMode csFixed
    var 
      datas:seq[ (string, string, string, string, string) ] = listOktato()
      s:string = ""
    text "text":
      box 320, 40 , 950, 600
      fill "#000000"
      font "IBM Plex Sans", 24, 400, 0, hLeft, vTop
      s.add "Kód\tVezetéknév\tKeresztnév\tSzak\tKezdés\n"
      for x in datas:
        s.add( ( x[0] & "\t" & $x[1] & "\t \t" & $x[2] & "\t \t" & $x[3] & "\t" & $x[4] & "\n") )
      characters s
      textAutoResize tsHeight
      layoutAlign laStretch
    rectangle "view":
      constraints cStretch, cMin
      counterAxisSizingMode csAuto
      box 315, 27, 950, 715
      fill "#d6d6d6"

proc hozzaAd() =
  frame "textLayout":
    counterAxisSizingMode csAuto
    text "kivalasztottTabla":
      box 430, 40, 100, 30
      fill "#000000"
      font "IBM Plex Sans", 26, 400, 0, hCenter, vCenter
      characters dropDownSelected
    group "dropdown":
      box 320, 40, 100, 30
      fill "#6d6d6d"
      cornerRadius 5
      strokeWeight 1
      onHover:
        fill "#9F9EB2"
      onClick:
        dropDownOpen = not dropDownOpen
      text "dropdown":
        box 12, 4 , 600, 600
        fill "#000000"
        font "IBM Plex Sans", 24, 400, 0, hLeft, vTop
        characters "Táblák"
        textAutoResize tsHeight
        layoutAlign laStretch
      if dropDownOpen:
        frame "dropDown":
          box 0, 30, 100, 100
          fill "#d6d6d6"
          cornerRadius 5
          layout lmVertical
          counterAxisSizingMode csAuto
          horizontalPadding 0
          verticalPadding 0
          itemSpacing 0
          clipContent true
          for buttonName in getTableNames():
            group "button":
              box 0, 80, 100, 20
              layoutAlign laCenter
              fill "#6d6d6d"
              cornerRadius 5
              strokeWeight 1
              onHover:
                fill "#9F9EB2"
              onClick:
                dropDownOpen = false
                dropDownSelected = buttonName
              text "kivalasztottGomb":
                box 0, 0, 100, 20
                fill "#000000"
                font "IBM Plex Sans", 18, 400, 0, hCenter, vCenter
                characters buttonName
    if (dropDownSelected != ""):  
      for i, x in getColumnsTable(dropDownSelected):
        if( x == "kod"):
          continue
        text "adatok":
          box 320 + (i*185), 60, 800, 100
          fill "#000000"
          font "IBM Plex Sans", 24, 400, 0, hLeft, vCenter
          var 
            s:string = ""
          s.add(x)
          characters s
      rectangle "bg":
        #box 20, 70, 800, 3
        #ne nagyon puszkáljam ha lehet
        box 340, 130, 870, 3
        fill "#000000"
        cornerRadius 5
        strokeWeight 1
    group "input":
      if (dropDownSelected != ""):
        textInput.setLen(getColumnsTable(dropDownSelected).len() )
        for i, x in getColumnsTable(dropDownSelected):
          if( x == "kod"):
            textInput[0] = " "
            continue
          text "text":
            box 335 + (i*185), 145, 140, 30
            fill "#000000"
            strokeWeight 1
            font "IBM Plex Sans", 22, 400, 0, hLeft, vCenter
            if textInput.len != 0:
              binding textInput[i]
          rectangle "bg":
            box 320 + (i*185), 140, 140, 30
            stroke "#72bdd0"
            cornerRadius 5
            strokeWeight 1
    group "button":
      if (dropDownSelected != ""):
        box 320, 200, 100, 30
        cornerRadius 5
        fill "#6d6d6d"
        onHover:
          fill "#9F9EB2"
        onDown:
          fill "#a5cddc"
          if( all( textInput, proc (x:string ):bool = x != "" ) ):
            ready = true
          if ready:

            # VEGREHAJTANDO ALGO

            insertData( dropDownSelected, textInput )

            echo textInput
          for i in countup(0, textInput.len()-1):
            textInput[i] = ""
        text "text":
          box 0, 5, 90, 20
          fill "#000000"
          font "IBM Plex Sans", 24, 200, 0, hCenter, vCenter
          characters "Csinál"
    rectangle "view":
      constraints cStretch, cMin
      counterAxisSizingMode csAuto
      box 315, 27, 950, 715
      fill "#d6d6d6"

proc torles() =
  frame "textLayout":
    counterAxisSizingMode csAuto
    text "kivalasztottTabla":
      box 430, 40, 100, 30
      fill "#000000"
      font "IBM Plex Sans", 26, 400, 0, hCenter, vCenter
      characters dropDownSelected
    group "dropdown":
      box 320, 40, 100, 30
      fill "#6d6d6d"
      cornerRadius 5
      strokeWeight 1
      onHover:
        fill "#9F9EB2"
      onClick:
        dropDownOpen = not dropDownOpen
      text "dropdown":
        box 12, 4 , 600, 600
        fill "#000000"
        font "IBM Plex Sans", 24, 400, 0, hLeft, vTop
        characters "Táblák"
        textAutoResize tsHeight
        layoutAlign laStretch
      if dropDownOpen:
        frame "dropDown":
          box 0, 30, 100, 100
          fill "#d6d6d6"
          cornerRadius 5
          layout lmVertical
          counterAxisSizingMode csAuto
          horizontalPadding 0
          verticalPadding 0
          itemSpacing 0
          clipContent true
          for buttonName in getTableNames():
            group "button":
              box 0, 80, 100, 20
              layoutAlign laCenter
              fill "#6d6d6d"
              cornerRadius 5
              strokeWeight 1
              onHover:
                fill "#9F9EB2"
              onClick:
                dropDownOpen = false
                dropDownSelected = buttonName
              text "kivalasztottGomb":
                box 0, 0, 100, 20
                fill "#000000"
                font "IBM Plex Sans", 18, 400, 0, hCenter, vCenter
                characters buttonName
    if (dropDownSelected != ""):  
      var
        x = getColumnsTable(dropDownSelected)[0]
      text "adatok":
        box 320, 60, 800, 100
        fill "#000000"
        font "IBM Plex Sans", 24, 400, 0, hLeft, vCenter
        var 
          s:string = ""
        s.add(x)
        characters s
      rectangle "bg":
        #box 20, 70, 800, 3
        #ne nagyon puszkáljam ha lehet
        box 340, 130, 870, 3
        fill "#000000"
        cornerRadius 5
        strokeWeight 1
    group "input":
      if (dropDownSelected != ""):
          text "text":
            box 335, 145, 140, 30
            fill "#000000"
            strokeWeight 1
            font "IBM Plex Sans", 22, 400, 0, hLeft, vCenter
            binding singleInput
          rectangle "bg":
            box 320, 140, 140, 30
            stroke "#72bdd0"
            cornerRadius 5
            strokeWeight 1
    group "button":
      if (dropDownSelected != ""):
        box 320, 200, 100, 30
        cornerRadius 5
        fill "#6d6d6d"
        onHover:
          fill "#9F9EB2"
        onDown:
          fill "#a5cddc"
          if( singleInput != "" ):
            ready = true
          if ready:

            # VEGREHAJTANDO ALGO

            deleteData( dropDownSelected, singleInput )

            echo singleInput
            singleInput = ""
        text "text":
          box 0, 5, 90, 20
          fill "#000000"
          font "IBM Plex Sans", 24, 200, 0, hCenter, vCenter
          characters "Csinál"
    rectangle "view":
      constraints cStretch, cMin
      counterAxisSizingMode csAuto
      box 315, 27, 950, 715
      fill "#d6d6d6"

proc modositas() =
  frame "textLayout":
    counterAxisSizingMode csAuto
    text "kivalasztottTabla":
      box 430, 40, 100, 30
      fill "#000000"
      font "IBM Plex Sans", 26, 400, 0, hCenter, vCenter
      characters dropDownSelected
    group "dropdown":
      box 320, 40, 100, 30
      fill "#6d6d6d"
      cornerRadius 5
      strokeWeight 1
      onHover:
        fill "#9F9EB2"
      onClick:
        dropDownOpen = not dropDownOpen
      text "dropdown":
        box 12, 4 , 600, 600
        fill "#000000"
        font "IBM Plex Sans", 24, 400, 0, hLeft, vTop
        characters "Táblák"
        textAutoResize tsHeight
        layoutAlign laStretch
      if dropDownOpen:
        frame "dropDown":
          box 0, 30, 100, 100
          fill "#d6d6d6"
          cornerRadius 5
          layout lmVertical
          counterAxisSizingMode csAuto
          horizontalPadding 0
          verticalPadding 0
          itemSpacing 0
          clipContent true
          for buttonName in getTableNames():
            group "button":
              box 0, 80, 100, 20
              layoutAlign laCenter
              fill "#6d6d6d"
              cornerRadius 5
              strokeWeight 1
              onHover:
                fill "#9F9EB2"
              onClick:
                dropDownOpen = false
                dropDownSelected = buttonName
              text "kivalasztottGomb":
                box 0, 0, 100, 20
                fill "#000000"
                font "IBM Plex Sans", 18, 400, 0, hCenter, vCenter
                characters buttonName
    if (dropDownSelected != ""):  
      var
        x = getColumnsTable(dropDownSelected)[0]
      text "adatok":
        box 320, 60, 800, 100
        fill "#000000"
        font "IBM Plex Sans", 24, 400, 0, hLeft, vCenter
        var 
          s:string = ""
        s.add(x)
        characters s
      rectangle "bg":
        #box 20, 70, 800, 3
        #ne nagyon puszkáljam ha lehet
        box 340, 130, 870, 3
        fill "#000000"
        cornerRadius 5
        strokeWeight 1
    group "input":
      if (dropDownSelected != ""):
          text "text":
            box 335, 145, 140, 30
            fill "#000000"
            strokeWeight 1
            font "IBM Plex Sans", 22, 400, 0, hLeft, vCenter
            binding singleInput
          rectangle "bg":
            box 320, 140, 140, 30
            stroke "#72bdd0"
            cornerRadius 5
            strokeWeight 1
    group "button":
      if (dropDownSelected != ""):
        box 320, 200, 100, 30
        cornerRadius 5
        fill "#6d6d6d"
        onHover:
          fill "#9F9EB2"
        onDown:
          fill "#a5cddc"
          if( singleInput != "" ):
            ready = true
          if ready:

            # VEGREHAJTANDO ALGO
            changeData( dropDownSelected, singleInput, textInput)

            echo singleInput
            singleInput = ""
        text "text":
          box 0, 5, 90, 20
          fill "#000000"
          font "IBM Plex Sans", 24, 200, 0, hCenter, vCenter
          characters "Módosit"
    group "search":
      if (dropDownSelected != ""):  
        text "adatok":
          box 340 , 220, 800, 100
          fill "#000000"
          font "IBM Plex Sans", 24, 400, 0, hLeft, vCenter
          characters "Adatok:"
        rectangle "bg":
          #ne nagyon puszkáljam ha lehet
          box 360, 250, 870, 3
          fill "#000000"
          cornerRadius 5
          strokeWeight 1
    group "searchResult":
      if (dropDownSelected != ""):
          text "adatok":
            box 340, 280, 800, 100
            fill "#000000"
            font "IBM Plex Sans", 24, 400, 0, hLeft, vCenter
            
            var 
              s:string = searchKey( dropDownSelected, singleInput )
            characters s
    if (dropDownSelected != ""):  
      for i, x in getColumnsTable(dropDownSelected):
        if( x == "kod"):
          continue
        text "adatok":
          box 320 + (i*185), 330, 800, 100
          fill "#000000"
          font "IBM Plex Sans", 24, 400, 0, hLeft, vCenter
          var 
            s:string = ""
          s.add(x)
          characters s
    group "input":
      if (dropDownSelected != ""):
        textInput.setLen(getColumnsTable(dropDownSelected).len() )
        for i, x in getColumnsTable(dropDownSelected):
          if( x == "kod"):
            textInput[0] = " "
            continue
          text "text":
            box 335 + (i*185), 400, 140, 30
            fill "#000000"
            strokeWeight 1
            font "IBM Plex Sans", 22, 400, 0, hLeft, vCenter
            if textInput.len != 0:
              binding textInput[i]
          rectangle "bg":
            box 320 + (i*185), 395, 140, 30
            stroke "#72bdd0"
            cornerRadius 5
            strokeWeight 1
    rectangle "view":
      constraints cStretch, cMin
      counterAxisSizingMode csAuto
      box 315, 27, 950, 715
      fill "#d6d6d6"

proc drawMain() = 
    frame "NotNeptun":
      counterAxisSizingMode csAuto
      setTitle "NotNeptun"
      orgBox 0, 0, 1024, 768
      box root.box
      fill "#525252"

      for i, tabName in ["Hallgatók","Oktatók", "Kurzusok", 
      "Termek", "Épületek", "Hozzáadás", "Módositás", "Törlés"]:
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
            if selectedTab == tabName:
              fill "#94d5ff"
            else:
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
        of "Oktatók":
          viewOktatok()
        of "Kurzusok":
          viewKurzusok()
        of "Termek":
          viewTermek()
        of "Épületek":
          viewEpuletek()
        of "Hozzáadás":
          hozzaAd()
        of "Módositás":
          modositas()
        of "Törlés":
          torles()

startFidget(drawMain, w=1300, h=768 )