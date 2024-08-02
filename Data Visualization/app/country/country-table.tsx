"use client";
import {
  Select,
  SelectContent,
  SelectGroup,
  SelectItem,
  SelectLabel,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import {
  Table,
  TableBody,
  TableCaption,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import { Country } from "@/lib/types/country";
import { Stock } from "@/lib/types/stock";
import { useState } from "react";
const CountryTable = ({
  stocks,
  countries,
}: {
  stocks: Stock[];
  countries: Country[];
}) => {
  const [selectedCountry, setSelectedCountry] = useState(" USA");

  const filteredStocks = stocks.filter(
    (stock) => stock.country_name === selectedCountry
  );

  return (
    <div className="flex flex-col gap-10 w-full">
      <Select defaultValue=" USA" onValueChange={setSelectedCountry}>
        <SelectTrigger className="w-[180px]">
          <SelectValue placeholder="Select a country" />
        </SelectTrigger>
        <SelectContent>
          <SelectGroup>
            {countries.map((country) => (
              <SelectItem
                value={country.country_name}
                key={country.country_name}
              >
                {country.country_name}
              </SelectItem>
            ))}
          </SelectGroup>
        </SelectContent>
      </Select>

      <Table className="border border-muted">
        <TableCaption>Top companies by market Cap</TableCaption>
        <TableHeader>
          <TableRow>
            <TableHead className="w-[50px]">No</TableHead>
            <TableHead>Stock Code</TableHead>
            <TableHead>Company Name</TableHead>
            <TableHead>Market Cap</TableHead>
            <TableHead>Current Price</TableHead>
            <TableHead>Country</TableHead>
          </TableRow>
        </TableHeader>
        <TableBody>
          {filteredStocks.map((stock: Stock, index: number) => (
            <TableRow key={stock.stock_code}>
              <TableCell className="w-[50px]">{index + 1}</TableCell>
              <TableCell>{stock.stock_code}</TableCell>
              <TableCell>{stock.company_name}</TableCell>
              <TableCell>${stock.current_marketcap}</TableCell>
              <TableCell>${stock.current_price}</TableCell>
              <TableCell>{stock.country_name}</TableCell>
            </TableRow>
          ))}
        </TableBody>
      </Table>
    </div>
  );
};

export default CountryTable;
