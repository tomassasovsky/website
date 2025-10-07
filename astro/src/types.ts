export interface SocialLink { label: string; icon: string; href: string; }
export interface Service { title: string; icon: string; description: string; }
export interface Testimonial { author: string; paragraphs: string[]; dateISO: string; dateLabel?: string; }
export interface Client { name: string; logo: string; url: string; logoClass?: string; }
export interface Role { title: string; range: string; description: string; }
export interface ProjectLink { label: string; icon: string; href: string; }
export interface Project { title: string; description: string; image: string; links: ProjectLink[]; category: string; }
export interface ContactSettings { endpoint: string; cooldownSeconds: number; fallbackEmail: string; }
export interface NavItem { label: string; href: string; }

export interface Booking {
  ctaTitle: string;
  description: string[];
  url: string;
}

