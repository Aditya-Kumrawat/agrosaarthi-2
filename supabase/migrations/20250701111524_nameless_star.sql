/*
  # Update scans table RLS policies

  1. Security Changes
    - Enable RLS on scans table
    - Add policies for users to manage their own scans
    - Fix foreign key reference to public.users
*/

-- Enable RLS on scans table
ALTER TABLE scans ENABLE ROW LEVEL SECURITY;

-- Drop existing foreign key constraint
ALTER TABLE scans DROP CONSTRAINT IF EXISTS scans_user_id_fkey;

-- Add new foreign key constraint to public.users
ALTER TABLE scans ADD CONSTRAINT scans_user_id_fkey 
  FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;

-- Policy: Users can read their own scans
CREATE POLICY "Users can read own scans"
  ON scans
  FOR SELECT
  TO authenticated
  USING (user_id = auth.uid());

-- Policy: Users can insert their own scans
CREATE POLICY "Users can insert own scans"
  ON scans
  FOR INSERT
  TO authenticated
  WITH CHECK (user_id = auth.uid());

-- Policy: Users can update their own scans
CREATE POLICY "Users can update own scans"
  ON scans
  FOR UPDATE
  TO authenticated
  USING (user_id = auth.uid());

-- Policy: Users can delete their own scans
CREATE POLICY "Users can delete own scans"
  ON scans
  FOR DELETE
  TO authenticated
  USING (user_id = auth.uid());