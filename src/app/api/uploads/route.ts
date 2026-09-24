const MAX_BYTES = 10 * 1024 * 1024;

const ALLOWED_TYPES = new Set(["image/png", "image/jpeg", "application/pdf"]);

export async function POST(request: Request) {
  const declaredLength = Number(request.headers.get("content-length") ?? "0");
  if (Number.isFinite(declaredLength) && declaredLength > MAX_BYTES) {
    return Response.json({ error: "file exceeds 10MB" }, { status: 413 });
  }

  let form: FormData;
  try {
    form = await request.formData();
  } catch {
    return Response.json({ error: "expected multipart form data" }, { status: 400 });
  }

  const file = form.get("file");
  if (!(file instanceof File)) {
    return Response.json({ error: "file is required" }, { status: 400 });
  }
  if (file.size === 0) {
    return Response.json({ error: "file is empty" }, { status: 400 });
  }
  if (file.size > MAX_BYTES) {
    return Response.json({ error: "file exceeds 10MB" }, { status: 413 });
  }
  if (!ALLOWED_TYPES.has(file.type)) {
    return Response.json({ error: "unsupported media type" }, { status: 415 });
  }

  return Response.json(
    {
      id: crypto.randomUUID(),
      size: file.size,
      contentType: file.type,
    },
    { status: 201 },
  );
}
