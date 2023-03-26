Program BrokerMenu;
uses crt;
Type
   Stock =  Record
      Name:  string;
      Volume:  Integer;
      Price:  Real;
   End;
Var
   Stocks:  Array[1..5] Of Stock;
   BrokerCash:  Real =  10000;

Procedure InitializeStocks;
var
  StockFile: text;
  StockName: string;
  StockVolume: integer;
  StockPrice: real;
  i: integer;
  c: char; 
begin
  i := 1;
  assign(StockFile, 'stocks.txt');
  reset(StockFile);
  while not eof(StockFile) do
  begin
    c := chr(0);
    StockName := '';
    while c <> ' ' do
    begin
      read(StockFile, c);
      StockName := StockName + c;
    end;

    readln(StockFile, StockVolume, StockPrice);
    Stocks[i].Name := StockName;
    Stocks[i].Volume := StockVolume;
    Stocks[i].Price := StockPrice;
    writeln('Initialized stock ', i, ' with values: ', Stocks[i].Name, ' ', Stocks[i].Volume, ' ', ' $' ,Stocks[i].Price:0:2);
    i := i + 1;
  end;
  close(StockFile);
end;

Procedure PrintStocks;
Var
   i:  Integer;
Begin
   Writeln('----------------------------------');
   Writeln('Current state of all stocks');
   Writeln('----------------------------------');
   For i := 1 To 5 Do
      Begin
         Writeln(Stocks[i].Name, ' Volume:', Stocks[i].Volume, ' Price:', Stocks[i].Price:0:2,
                 ' Total Value:', Stocks[i].Volume * Stocks[i].Price:0:2);
      End;
End;

Procedure PrintPortfolio;
Var
   i:  Integer;
   TotalValue:  Real;
Begin
   Writeln('----------------------------------');
   Writeln('Current portfolio of broker');
   Writeln('----------------------------------');
   TotalValue := BrokerCash;
   For i := 1 To 5 Do
      Begin
         If Stocks[i].Volume > 0 Then
            Begin
               Writeln(Stocks[i].Name, ' Volume:', Stocks[i].Volume, ' Price:', Stocks[i].Price:0:2,
                       ' Total Value:', Stocks[i].Volume * Stocks[i].Price:0:2);
               TotalValue := TotalValue + Stocks[i].Volume * Stocks[i].Price;
            End;
      End;
   Writeln('Cash in hand:', BrokerCash:0:2);
   Writeln('Total portfolio value:', TotalValue:0:2);
End;

Procedure BuyStock;
Var
   StockIndex, Volume:  Integer;
   NewPrice:  Real;
   Cost:  Real;
Begin
   write('Enter stock number (1-5): ');
   Readln(StockIndex);
   write('Enter volume: ');
   Readln(Volume);
   write('Enter new price: ');
   Readln(NewPrice);
   If (StockIndex >= 1) And (StockIndex <= 5) Then
      Begin
         If BrokerCash >= Volume * NewPrice Then
            Begin
               Cost := Volume * NewPrice;
               Stocks[StockIndex].Volume := Stocks[StockIndex].Volume - Volume;
               Stocks[StockIndex].Price := NewPrice;
               BrokerCash := BrokerCash - Cost;
               Writeln('Stock purchased successfully.');
            End
         Else
            Begin
               Writeln('Not enough cash to buy stock.');
            End;
      End
   Else
      Begin
         Writeln('Invalid stock number.');
      End;
End;

Procedure SellStock;
Var
   StockIndex, Volume:  Integer;
   NewPrice:  Real;
   Revenue:  Real;
Begin
   write('Enter stock number (1-5): ');
   Readln(StockIndex);
   write('Enter volume: ');
   Readln(Volume);
   write('Enter new price: ');
   Readln(NewPrice);
   If (StockIndex >= 1) And (StockIndex <= 5) Then
      Begin
         If Stocks[StockIndex].Volume >= Volume Then
            Begin
               Revenue := Volume * NewPrice;
               Stocks[StockIndex].Volume := Stocks[StockIndex].Volume + Volume;
               Stocks[StockIndex].Price := NewPrice;
               BrokerCash := BrokerCash + Revenue;
               Writeln('Stock sold successfully.');
            End
         Else
            Begin
               Writeln('Not enough stock to sell.');
            End;
      End
   Else
      Begin
         Writeln('Invalid stock number.');
      End;
End;

Procedure ShowMenu;
Var
   Choice:  Integer;
Begin
   Repeat
      Writeln('----------------------------------');
      Writeln('Main Menu');
      Writeln('----------------------------------');
      Writeln('1. Buy');
      Writeln('2. Sell');
      Writeln('3. CurrentState');
      Writeln('4. Exit');
      write('Enter your choice: ');
      Readln(Choice);
      Case Choice Of
         1:  BuyStock;
         2:  SellStock;
         3:
             Begin
                PrintStocks;
                PrintPortfolio;
             End;
         4:  Writeln('Exiting program.');
         Else Writeln('Invalid choice.');
      End;
   Until Choice = 4;
End;
Begin
   InitializeStocks;
   ShowMenu;
End.
