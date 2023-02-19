export function serial(tasks, fn) {
    return tasks
        .reduce(
            (promise, task) => promise
                .then(previous => fn(task, previous)),
            Promise.resolve(null)
        );
}
