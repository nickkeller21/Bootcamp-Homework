Attribute VB_Name = "Module1"
Sub easy()
    
    For Each ws In Worksheets
  
'------------------------------------------------------------------------------------------------------------
' Declare Variables and set initital values
'------------------------------------------------------------------------------------------------------------
  
        Dim stock As String
        Dim stockTotal As Double
        stockTotal = 0
        Dim summaryRow As Long
        summaryRow = 2
        Dim LastRow As Long
        LastRow = Cells(Rows.Count, "A").End(xlUp).Row
        Dim openValue As Double
        Dim closeValue As Double
        Dim yearlyChange As Double
        Dim percentChange As Double
        openValue = Worksheets(ws.Name).Cells(2, 3).Value
        
'------------------------------------------------------------------------------------------------------------
' Set Headers
'------------------------------------------------------------------------------------------------------------
        Worksheets(ws.Name).Cells(1, 10).Value = "Stock"
        Worksheets(ws.Name).Cells(1, 13).Value = "Total vol"
        
'------------------------------------------------------------------------------------------------------------
' Add Stock and Total Vol
'------------------------------------------------------------------------------------------------------------
        For i = 2 To LastRow
        
             ' Check if we are still within the same stock, if it is not...
            If Worksheets(ws.Name).Cells(i + 1, 1).Value <> Worksheets(ws.Name).Cells(i, 1).Value Then
              ' Set the Stock name
                stock = Worksheets(ws.Name).Cells(i, 1).Value
 
              ' Add to the Stock volume
                stockTotal = stockTotal + Worksheets(ws.Name).Cells(i, 7).Value
        
              ' Print the stock name in the Summary Table column j
                Worksheets(ws.Name).Cells(summaryRow, 10).Value = stock
        
              ' Print the total stock volume to the Summary Table column m
                Worksheets(ws.Name).Cells(summaryRow, 13).Value = stockTotal
        
              ' Add one to the summary table row
                summaryRow = summaryRow + 1
              
              ' Reset the stock Total
                stockTotal = 0

            ' If the cell immediately following a row is the same brand...
            Else
        
              ' Add to the stock Total
                stockTotal = stockTotal + Worksheets(ws.Name).Cells(i, 7).Value
        
            End If
            
            

                
            
        Next i
'-------------------------------------------------------------------------------------------------------------------------------
    Next ws

End Sub

Sub medium()
        For Each ws In Worksheets
  
'------------------------------------------------------------------------------------------------------------
' Declare Variables and set initital values
'------------------------------------------------------------------------------------------------------------
  
        Dim stock As String
        Dim stockTotal As Double
        stockTotal = 0
        Dim summaryRow As Long
        summaryRow = 2
        Dim LastRow As Long
        LastRow = Cells(Rows.Count, "A").End(xlUp).Row
        Dim openValue As Double
        Dim closeValue As Double
        Dim yearlyChange As Double
        Dim percentChange As Double
        openValue = Worksheets(ws.Name).Cells(2, 3).Value
'------------------------------------------------------------------------------------------------------------
' Set Headers
'------------------------------------------------------------------------------------------------------------
        Worksheets(ws.Name).Cells(1, 11).Value = "Yearly Change"
        Worksheets(ws.Name).Cells(1, 12).Value = "Percent Change"
'------------------------------------------------------------------------------------------------------------
' Add Stock and Total Vol
'------------------------------------------------------------------------------------------------------------
        For i = 2 To LastRow
        

            
            
'------------------------------------------------------------------------------------------------------------
' Fill Yearly Change and pecent change
'------------------------------------------------------------------------------------------------------------
            If (Worksheets(ws.Name).Cells(i + 1, 1).Value <> Worksheets(ws.Name).Cells(i, 1).Value And i > 3) Then
                closeValue = Worksheets(ws.Name).Cells(i, 6).Value
                yearlyChange = closeValue - openValue
                Worksheets(ws.Name).Cells(summaryRow, 11).Value = yearlyChange
                
                If openValue <> 0 Then
                    percentChange = yearlyChange / openValue
                    Worksheets(ws.Name).Cells(summaryRow, 12).Value = percentChange
                End If
                
                openValue = Worksheets(ws.Name).Cells(i + 1, 3).Value
                Worksheets(ws.Name).Cells(summaryRow, 12).NumberFormat = "0.00%"
                If yearlyChange > 0 Then
                    Worksheets(ws.Name).Cells(summaryRow, 11).Interior.ColorIndex = 4
                ElseIf yearlyChange < 0 Then
                    Worksheets(ws.Name).Cells(summaryRow, 11).Interior.ColorIndex = 3
                End If
                
                
                summaryRow = summaryRow + 1
            End If
            
                
            
        Next i
'-------------------------------------------------------------------------------------------------------------------------------
    Next ws
End Sub

Sub hard()
    For Each ws In Worksheets
        Dim LastRow As Long
        LastRow = Cells(Rows.Count, "L").End(xlUp).Row
        Dim max As Double
        Dim min As Double
        Dim maxStock As String
        Dim minStock As String
        Dim highestTotal As Double
        Dim highestStock As String
        max = 0
        min = 0
        highestTotal = 0
'------------------------------------------------------------------------------------------------------------
' labels
'------------------------------------------------------------------------------------------------------------
        Worksheets(ws.Name).Cells(1, 15).Value = "Ticker"
        Worksheets(ws.Name).Cells(1, 16).Value = "Value"
        Worksheets(ws.Name).Cells(2, 14).Value = "Greatest % Increase"
        Worksheets(ws.Name).Cells(3, 14).Value = "Greatest % Decrease"
        Worksheets(ws.Name).Cells(4, 14).Value = "Greatest Total Value"
'---------------------------------------------------------------------------------------------------------------------
' fill in stats of greatest % increase and decrease and total value
'---------------------------------------------------------------------------------------------------------------------
        For i = 2 To LastRow
            
            If Worksheets(ws.Name).Cells(i, 12).Value > max Then
                max = Worksheets(ws.Name).Cells(i, 12).Value
                maxStock = Worksheets(ws.Name).Cells(i, 10).Value
            ElseIf Worksheets(ws.Name).Cells(i, 12).Value < min Then
                min = Worksheets(ws.Name).Cells(i, 12).Value
                minStock = Worksheets(ws.Name).Cells(i, 10).Value
            End If
            If Worksheets(ws.Name).Cells(i, 13).Value > highestTotal Then
                highestTotal = Worksheets(ws.Name).Cells(i, 13).Value
                highestStock = Worksheets(ws.Name).Cells(i, 10).Value
            End If
        Next i
        Worksheets(ws.Name).Cells(2, 15).Value = maxStock
        Worksheets(ws.Name).Cells(2, 16).Value = max
        Worksheets(ws.Name).Cells(2, 16).NumberFormat = "0.00%"
        Worksheets(ws.Name).Cells(3, 15).Value = minStock
        Worksheets(ws.Name).Cells(3, 16).Value = min
        Worksheets(ws.Name).Cells(3, 16).NumberFormat = "0.00%"
        Worksheets(ws.Name).Cells(4, 15).Value = highestStock
        Worksheets(ws.Name).Cells(4, 16).Value = highestTotal
        Worksheets(ws.Name).Columns("N:P").AutoFit
    Next ws
End Sub


































