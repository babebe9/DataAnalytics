Sub VBAtracker()

Dim lastRow As Long
Dim ticker As String
Dim Counter As Double
Dim Summary As Integer
Dim YearlyChange As Double
Dim openprice As Double
Dim PercentChange As Double


lastRow = Cells(Rows.Count, 1).End(xlUp).Row
Summary = 1
Cells(1, 10).Value = "Ticker"
Cells(1, 11).Value = "Yearly Change"
Cells(1, 12).Value = "Percent Change"
Cells(1, 13).Value = "Total Stock Volume"

openprice = Cells(2, 3).Value
 

For i = 2 To lastRow

If Cells(i + 1, 1).Value <> Cells(i, 1).Value Then
ticker = Cells(i, 1).Value
Counter = Counter + Cells(i, 7).Value
YearlyChange = Cells(i, 6).Value - openprice
PercentChange = Round((((Cells(i, 6).Value - openprice) / openprice) * 100), 2)

Summary = Summary + 1

Cells(Summary, 10).Value = ticker
Range("K" & Summary).Value = YearlyChange
Cells(Summary, 12).Value = PercentChange
Cells(Summary, 13).Value = Counter
Counter = 0
openprice = Cells(i + 1, 3).Value

Range("K" & Summary).Interior.ColorIndex = 3

If Range("K" & Summary) > 0 Then Range("K" & Summary).Interior.ColorIndex = 4
Else
Counter = Counter + Cells(i, 7).Value

 
     
End If
Next i

MsgBox ("Completed")
End Sub

