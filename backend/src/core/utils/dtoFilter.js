export const removeFalsy = obj => {
    const newObj = {};
    Object.keys(obj).forEach(prop => {
        if (obj[prop]) { newObj[prop] = obj[prop]; }
    });
    return newObj;
};
