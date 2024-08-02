import { getStocksWithCategory } from "@/lib/queries";
import { NextRequest, NextResponse } from "next/server";

type Params = {
  category: string;
};
export const GET = async (req: NextRequest, context: { params: Params }) => {
  const { category } = context.params;
  const res = await getStocksWithCategory(category);

  return NextResponse.json(res);
};
