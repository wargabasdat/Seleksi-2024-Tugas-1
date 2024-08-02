import Link from "next/link";

const Navbar = () => {
  return (
    <header className="w-full h-20 shadow-lg">
      <nav className="flex items-center justify-center h-full p-4 gap-20">
        <Link className="text-2xl font-bold" href="/">
          Data Visualization
        </Link>
        <Link className="text-2xl font-bold" href="/category">
          By Categories
        </Link>{" "}
        <Link className="text-2xl font-bold" href="/country">
          By Countries
        </Link>{" "}
      </nav>
    </header>
  );
};

export default Navbar;
