export interface SocialLink { label: string; icon: string; href: string; }
export interface Service { title: string; icon: string; description: string; }
export interface Testimonial {
  author: string;
  paragraphs: string[];
  dateISO: string;
  dateLabel?: string;
  linkedinUrl?: string;
  contactUrl?: string;
}
export type Client = {
  name: string;
  url: string;
  logoClass?: string;
} & (
  | { logo: string }
  | { lightLogo: string; darkLogo: string }
);
export interface Role { title: string; range: string; description: string; }
export interface ProjectLink { label: string; icon: string; href: string; }
export interface Project { title: string; description: string; image?: string; imageFit?: 'cover' | 'contain' | 'fill' | 'none' | 'scale-down'; links?: ProjectLink[]; categories: string[]; unreleased?: boolean; tech?: string[]; }
export interface ContactSettings { endpoint: string; cooldownSeconds: number; fallbackEmail: string; }
export interface NavItem { label: string; href: string; enabled?: boolean; }

export interface Booking {
  ctaTitle: string;
  description: string[];
  url: string;
}

