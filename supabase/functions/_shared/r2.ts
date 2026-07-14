export interface R2Config {
  accountId: string;
  accessKeyId: string;
  secretAccessKey: string;
  bucket: string;
}

export function getR2Config(): R2Config {
  const accountId = Deno.env.get("R2_ACCOUNT_ID");
  const accessKeyId = Deno.env.get("R2_ACCESS_KEY");
  const secretAccessKey = Deno.env.get("R2_SECRET_KEY");
  const bucket = Deno.env.get("R2_BUCKET");

  if (!accountId) {
    throw new Error("Missing R2_ACCOUNT_ID");
  }

  if (!accessKeyId) {
    throw new Error("Missing R2_ACCESS_KEY");
  }

  if (!secretAccessKey) {
    throw new Error("Missing R2_SECRET_KEY");
  }

  if (!bucket) {
    throw new Error("Missing R2_BUCKET");
  }

  return {
    accountId,
    accessKeyId,
    secretAccessKey,
    bucket,
  };
}

export function generateObjectPath(
  folder: string,
  extension: string,
): string {
  const uuid = crypto.randomUUID();

  return `${folder}/${uuid}.${extension}`;
}

export function endpoint(config: R2Config): string {
  return `https://${config.accountId}.r2.cloudflarestorage.com/${config.bucket}`;
}