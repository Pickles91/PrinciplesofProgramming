{
*********************************************************************
  Author: Steven Sommer
  Course: CS 415 - Principles of Programming Languages
  Assignment Name: Pascal Program
  Description: Create a menu to enable the broker to select and buy or sell stocks from
	             reading in an input file of stocks -
							 stocks.txt with initial stock values (name, volume, price) for 5 stocks.
							 The broker has initial cash in hand - $10000.
               view current state, and exit.

            Buy                 Select a stock
					                      then - number, new price
                                decreases the volume by number and sets the stock-price to
                                the new price

						Sell                Select a stock
                                then - number, new price
                                increases the volume by number and sets the stock-price to
                                the new price

           CurrentState         Prints the current state of all the stocks - volume and price, and total value of the stock
                                Then prints the current portfolio of the broker
                                The stocks held by broker, and cash in hand.

            Exit                 Exit the application.

		this one
*********************************************************************
}

program StockBroker;
uses crt, sysutils;

type
  Stock = record
    name: string;
    volume: integer;
    price: real;
  end;

var
  stocks: array [1..5] of Stock;
  cash: real;
  choice: integer;
  quantity: integer;
  filename: string;
  infile: text;

procedure LoadStocksFromFile(filename: string);
var
  i: integer;
begin
  ASSIGN(infile, 'C:\Academic_Development\infile.txt');
  reset(infile);
  for i := 1 to 5 do
  begin
    readln(infile, stocks[i].name, stocks[i].volume, stocks[i].price);
		writeln('Name: ', stocks[i].name, ' (', stocks[i].volume, '): $', stocks[i].price:0:2);
  end;
  close(infile);
end;

procedure DisplayStocks();
var
  i: integer;
begin
  writeln('Stocks available:');
  for i := 1 to 5 do
  begin
    writeln('Name: ', stocks[i].name, ' (', stocks[i].volume, '): $', stocks[i].price:0:2);
  end;
end;

procedure BuyStock();
begin
  writeln('Which stock would you like to buy?');
  DisplayStocks();
  readln(choice);
  writeln('How many shares would you like to buy?');
  readln(quantity);
  if (stocks[choice].volume >= quantity) and (stocks[choice].price * quantity <= cash) then
  begin
    stocks[choice].volume := stocks[choice].volume - quantity;
    cash := cash - stocks[choice].price * quantity;
    writeln('Bought ', quantity, ' shares of ', stocks[choice].name, ' for $', stocks[choice].price * quantity:0:2);
  end
  else
  begin
    writeln('Not enough shares or cash available');
  end;
end;

procedure SellStock();
begin
  writeln('Which stock would you like to sell?');
  DisplayStocks();
  readln(choice);
  writeln('How many shares would you like to sell?');
  readln(quantity);
  if (stocks[choice].volume + quantity <= 10000) then
  begin
    stocks[choice].volume := stocks[choice].volume + quantity;
    cash := cash + stocks[choice].price * quantity;
    writeln('Sold ', quantity, ' shares of ', stocks[choice].name, ' for $', stocks[choice].price * quantity:0:2);
  end
  else
  begin
    writeln('Cannot sell more shares than currently available');
  end;
end;

begin
  cash := 10000;
  filename := 'C:\Academic_Development\stocks.txt';
  LoadStocksFromFile(filename);
  repeat
    writeln('What would you like to do?');
    writeln('1. View current stocks and prices');
    writeln('2. Buy stocks');
    writeln('3. Sell stocks');
    writeln('4. Exit');
    readln(choice);
    case choice of
      1: DisplayStocks();
      2: BuyStock();
      3: SellStock();
			4: exit;
    end;
    writeln('Cash in hand: $', cash:0:2);
    writeln;
  until choice = 4;
	halt;
end.
