import { serve } from "https://deno.land/std@0.224.0/http/server.ts";

serve(async (_req) => {
  try {
    return new Response(
      JSON.stringify({
        success: true,
        message: "Twimzi Upload Media Function",
        version: "1.0.0",
        status: "Ready",
      }),
      {
        headers: {
          "Content-Type": "application/json",
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Headers":
            "authorization, x-client-info, apikey, content-type",
        },
        status: 200,
      },
    );
  } catch (e) {
    return new Response(
      JSON.stringify({
        success: false,
        error: e instanceof Error ? e.message : "Unknown error",
      }),
      {
        headers: {
          "Content-Type": "application/json",
          "Access-Control-Allow-Origin": "*",
        },
        status: 500,
      },
    );
  }
});