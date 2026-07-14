import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

export const supabase = createClient(
  Deno.env.get("SUPABASE_URL")!,
  Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
);

export interface MediaRecord {
  uploaded_by: string;
  bucket_name: string;
  object_path: string;
  file_name: string;
  original_name: string;
  mime_type: string;
  extension: string;
  file_size: number;
  width?: number;
  height?: number;
  duration_seconds?: number;
  alt_text?: string;
  is_public?: boolean;
}

export async function createMediaRecord(
  media: MediaRecord,
): Promise<string> {
  const { data, error } = await supabase
    .from("media")
    .insert({
      uploaded_by: media.uploaded_by,
      bucket_name: media.bucket_name,
      object_path: media.object_path,
      file_name: media.file_name,
      original_name: media.original_name,
      mime_type: media.mime_type,
      extension: media.extension,
      file_size: media.file_size,
      width: media.width,
      height: media.height,
      duration_seconds: media.duration_seconds,
      alt_text: media.alt_text,
      is_public: media.is_public ?? true,
    })
    .select("id")
    .single();

  if (error) {
    throw error;
  }

  return data.id as string;
}