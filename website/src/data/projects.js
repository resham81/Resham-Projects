export const PROFILE = {
  name: 'Resham Furqan',
  role: 'Software · systems · design',
  tagline:
    'I build clear software — full-stack apps, network architecture, system-level programs, and user-centered design.',
  location: 'Dubai, UAE',
  phone: '+971 50 232 8219',
  phoneHref: 'tel:+971502328219',
  email: 'reshamfurqan28@gmail.com',
  emailHref: 'mailto:reshamfurqan28@gmail.com',
  linkedin: 'https://www.linkedin.com/in/resham-furqan-60263b2b8/',
  github: 'https://github.com/resham81/Resham-Projects',
  githubUser: 'https://github.com/resham81',
}

export const CERTIFICATIONS = [
  {
    title: 'Zoho Creator — Young Creators Program',
    detail: 'Low-code application development',
    org: 'Zoho',
  },
  {
    title: 'Red Hat System Administration I & II',
    detail: 'Linux administration (RHCSA pathway)',
    org: 'Red Hat',
  },
  {
    title: 'Cisco CCNA 1, 2 & 3',
    detail: 'Introduction to Networks · Switching, Routing & Wireless · Enterprise Networking',
    org: 'Cisco',
  },
  {
    title: 'e& Chatbot Hackathon',
    detail: 'EngageX Generative AI hackathon certificate',
    org: 'e& / EngageX',
  },
  {
    title: 'AWS Academy Cloud Foundations',
    detail: 'Cloud fundamentals on AWS',
    org: 'Amazon Web Services',
  },
]

export const SKILLS = [
  { id: 'web', label: 'Web', match: ['React', 'Vite', 'CSS', 'GitHub Pages'] },
  { id: 'python', label: 'Python', match: ['Python', 'NumPy', 'Matplotlib'] },
  { id: 'c', label: 'C & Systems', match: ['C', 'Unix', 'Makefile', 'Linked lists'] },
  { id: 'data', label: 'Data & SQL', match: ['MySQL', 'SQL'] },
  { id: 'ux', label: 'UI / UX', match: ['Figma', 'UI/UX', 'HCI'] },
  { id: 'cloud', label: 'Cloud', match: ['AWS'] },
  { id: 'networks', label: 'Networks', match: ['Network design'] },
]

const REPO = 'https://github.com/resham81/Resham-Projects/tree/main'

export const PROJECTS = [
  {
    id: 'portfolio-website',
    title: 'Personal Portfolio Website',
    description:
      'Beige and sage React portfolio with interactive project filters, certifications, and contact — hosted free on GitHub Pages for a shareable CV link.',
    tech: ['React', 'Vite', 'CSS', 'GitHub Pages'],
    course: 'Personal',
    year: 2026,
    path: 'projects/portfolio-website',
    demo: 'https://resham81.github.io/Resham-Projects/',
    demoLabel: 'Open live site',
    highlight: 'Frontend & deployment',
  },
  {
    id: 'disease-simulation',
    title: 'Disease Spread Simulation',
    description:
      'Grid-based population simulation that models how a disease spreads, with NumPy and Matplotlib visualization.',
    tech: ['Python', 'NumPy', 'Matplotlib'],
    course: 'FOP',
    year: 2024,
    path: 'projects/disease-simulation',
    demo: null,
    highlight: 'Simulation & visualisation',
  },
  {
    id: 'data-structures',
    title: 'Autonomous Vehicle Manager',
    description:
      'Interactive vehicle management system using a custom deque, graphs, and sorting algorithms in Python.',
    tech: ['Python'],
    course: 'DSA',
    year: 2025,
    path: 'projects/data-structures',
    demo: null,
    highlight: 'Algorithms & data structures',
  },
  {
    id: 'film-festival-database',
    title: 'Film Festival Database',
    description:
      'Full MySQL schema for film festivals, films, and awards, with advanced SQL features and a Python connector.',
    tech: ['MySQL', 'SQL', 'Python'],
    course: 'DBS',
    year: 2025,
    path: 'projects/film-festival-database',
    demo: null,
    highlight: 'Database engineering',
  },
  {
    id: 'unix-prime-checker',
    title: 'Unix Prime Checker',
    description:
      'C program using system calls, file I/O, and parent/child processes with pipes to check primes from a file.',
    tech: ['C', 'Unix', 'Makefile'],
    course: 'USP',
    year: 2025,
    path: 'projects/unix-prime-checker',
    demo: null,
    highlight: 'Systems programming',
  },
  {
    id: 'snake-treasure-game',
    title: 'Snake Treasure Game',
    description:
      'Terminal C game: navigate a map, avoid a snake, collect treasure — built with linked lists and a Makefile.',
    tech: ['C', 'Linked lists', 'Makefile'],
    course: 'C Programming',
    year: 2025,
    path: 'projects/snake-treasure-game',
    demo: null,
    highlight: 'Game logic in C',
  },
  {
    id: 'helpera',
    title: 'HelpEra',
    description:
      'HCI / UI-UX group project — app concept designed in Figma with research, reports, and walkthrough materials.',
    tech: ['Figma', 'UI/UX', 'HCI'],
    course: 'HCI',
    year: 2026,
    path: 'projects/helpera',
    demo:
      'https://www.figma.com/proto/dsLX75NhBuBNsLqNu9tgYn/Uxplorers---HelpEra?node-id=1161-2608&scaling=scale-down&content-scaling=fixed&page-id=0%3A1&starting-point-node-id=1161%3A2608&show-proto-sidebar=1',
    demoLabel: 'Open Figma',
    highlight: 'Product & UX design',
  },
  {
    id: 'network-system-design',
    title: 'Network System Design',
    description:
      'Group network system design assignments covering architecture and design documentation.',
    tech: ['Network design'],
    course: 'NSD',
    year: 2025,
    path: 'projects/network-system-design',
    demo: null,
    highlight: 'Network architecture',
  },
  {
    id: 'eco-travel-hub',
    title: 'EcoTravelHub',
    description:
      'Group business and app concept for sustainable travel, with an AWS demo video and business report.',
    tech: ['AWS', 'Business analysis'],
    course: 'MCC',
    year: 2025,
    path: 'projects/eco-travel-hub',
    demo: null,
    highlight: 'Cloud & product thinking',
  },
].map((p) => ({
  ...p,
  repoUrl: `${REPO}/${p.path}`,
}))
