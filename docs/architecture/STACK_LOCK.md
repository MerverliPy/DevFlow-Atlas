# STACK_LOCK

## Purpose
This file is the source of truth for the fixed technical stack of DevFlow Atlas V1.

## Locked stack
- Framework: Next.js 14
- Router: App Router
- Language: TypeScript
- Styling: Tailwind CSS
- Graph library: React Flow
- ORM: Prisma
- Database: PostgreSQL
- Auth: Clerk
- Deployment: Vercel
- Package manager: npm
- Node version: 20

## Why this stack is locked
This stack is fixed to reduce ambiguity for coding agents and lower manual rescue work.

## Do not change without explicit approval
- framework or major version
- routing model
- ORM
- database type
- auth provider
- graph library
- deployment target
- package manager

## Environment requirements
- Node 20
- npm
- PostgreSQL connection string
- Clerk publishable and secret keys

## Expected core commands later
- npm install
- npm run dev
- npm run lint
- npm run test
- npm run build
- npx prisma generate
- npx prisma migrate dev
