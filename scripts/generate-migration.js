#!/usr/bin/env node

const { execSync } = require('child_process');
const path = require('path');

// Get migration name from command line argument
const migrationName = process.argv[2];

if (!migrationName) {
  console.error('Error: Migration name is required');
  console.log('Usage: pnpm migration:generate <MigrationName>');
  console.log('Example: pnpm migration:generate AddUserTable');
  process.exit(1);
}

// Build the full path
const migrationPath = `src/db/migrations/${migrationName}`;

// Run TypeORM migration generate command
const command = `typeorm-ts-node-commonjs -d src/db/datasource.ts migration:generate ${migrationPath}`;

console.log(`Generating migration: ${migrationName}`);
console.log(`Path: ${migrationPath}`);

try {
  execSync(command, { stdio: 'inherit' });
  console.log('Migration generated successfully!');
} catch (error) {
  console.error('Migration generation failed');
  process.exit(1);
}
