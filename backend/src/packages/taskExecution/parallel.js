export function parallel(tasks, fn) {
    return Promise.all(tasks.map(task => fn(task)));
}
