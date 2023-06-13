function compress(path) {
  return fetch(path).then(res => res.blob()).then(blob => {
    return imageCompression(blob);
  });
}
