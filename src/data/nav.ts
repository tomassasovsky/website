import type { NavItem } from "../types";

export const navItems: NavItem[] = [
  { label: "About", href: "/" },
  { label: "Work", href: "/work", enabled: false },
  { label: "Projects", href: "/projects" },
  { label: "Contact", href: "/contact" },
];
