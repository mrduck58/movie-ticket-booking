enum AppErrorType {
  network,        // mất mạng, DNS, socket
  timeout,        // connect/send/receive timeout
  cancelled,      // user huỷ request
  unauthorized,   // 401
  forbidden,      // 403
  notFound,       // 404
  conflict,       // 409
  validation,     // 422 hoặc lỗi form
  rateLimited,    // 429
  server,         // 5xx
  parse,          // parse json / format
  unknown,        // fallback
}