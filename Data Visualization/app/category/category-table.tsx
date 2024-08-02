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
import { getStocksWithCategory } from "@/lib/queries";
import { Category } from "@/lib/types/category";
import { Stock } from "@/lib/types/stock";
import { useEffect, useState } from "react";
const CategoryTable = ({ categories }: { categories: Category[] }) => {
  const [selectedCategory, setSelectedCategory] = useState(
    "\ud83d\udee2 Oil&Gas"
  );

  const [stocks, setStocks] = useState<Stock[]>([]);

  useEffect(() => {
    const fetchData = async () => {
      const res = await fetch(`/api/${selectedCategory}`);
      const data = await res.json();
      setStocks(data);
    };

    fetchData();
  }, [selectedCategory]); // Dependen

  return (
    <div className="flex flex-col gap-10 w-full">
      <Select
        defaultValue="\ud83d\udee2 Oil&Gas"
        onValueChange={setSelectedCategory}
      >
        <SelectTrigger className="w-[180px]">
          <SelectValue placeholder="Select a Category" />
        </SelectTrigger>
        <SelectContent>
          <SelectGroup>
            {categories.map((Category) => (
              <SelectItem
                value={Category.category_name}
                key={Category.category_name}
              >
                {Category.category_name}
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
            <TableHead>Category</TableHead>
          </TableRow>
        </TableHeader>
        <TableBody>
          {stocks.map((stock: Stock, index: number) => (
            <TableRow key={stock.stock_code}>
              <TableCell className="w-[50px]">{index + 1}</TableCell>
              <TableCell>{stock.stock_code}</TableCell>
              <TableCell>{stock.company_name}</TableCell>
              <TableCell>${stock.current_marketcap}</TableCell>
              <TableCell>${stock.current_price}</TableCell>
              <TableCell>{selectedCategory}</TableCell>
            </TableRow>
          ))}
        </TableBody>
      </Table>
    </div>
  );
};

export default CategoryTable;
