"use client";
import {
  Table,
  TableBody,
  TableCaption,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import { Stock } from "@/lib/types/stock";
import { useRouter } from "next/navigation";
const MainTable = ({ stocks }: { stocks: any }) => {
  const router = useRouter();

  const onclick = (stock_code: string) => {
    router.push(`/detail/${stock_code}`);
  };
  return (
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
        {stocks.map((stock: Stock, index: number) => (
          <TableRow
            key={stock.stock_code}
            className="hover:cursor-pointer"
            onClick={() => onclick(stock.company_name)}
          >
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
  );
};

export default MainTable;
