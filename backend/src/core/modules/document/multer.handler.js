import { ROOT_DIR } from 'core/env';
import multer from 'multer';
import path from 'path';
import fs from 'fs';

export class MulterUploader {
    #destinationPath;

    #allowedExtensions;

    #keyName;

    #fileQuantity;

    #configurations = {
        storage: multer.diskStorage({
            destination: (req, file, cb) => {
                cb(null, this.#destinationPath);
            },
            filename: (req, file, cb) => {
                cb(null, this.getFileName(file));
            }
        }),
        fileFilter: (req, file, cb) => {
            if (!this.#allowedExtensions.includes(path.extname(file.originalname).toLocaleLowerCase())) {
                return cb(new multer.MulterError('File type not allowed'));
            }

            return cb(null, true);
        },
    };

    constructor(extensions, keyName, fileQuantity = 1, destinationPath = `${ROOT_DIR}/core/uploads`) {
        this.validateParams(extensions, destinationPath, keyName, fileQuantity);

        this.#allowedExtensions = extensions;

        this.#destinationPath = destinationPath;

        this.#keyName = keyName;

        this.#fileQuantity = fileQuantity;
    }

    validateParams(extensions, destinationPath, keyName, fileQuantity) {
        if (typeof extensions !== 'object' && extensions.length < 1) {
            throw new Error('extensions must be an array and contain at least 1 element');
        }

        fs.access(destinationPath, error => {
            if (error) {
                fs.mkdirSync(destinationPath);
            }
        });

        if (!keyName) {
            throw new Error('keyName is required');
        }

        if (fileQuantity && typeof fileQuantity !== 'number' && fileQuantity < 1) {
            throw new Error('fileQuantity must be a number greater than 0');
        }
    }

    getFileName(file) {
        const originalname = file.originalname.substr(0, file.originalname.lastIndexOf('.')) || file.originalname;
        return `${originalname}-${Date.now()}${path.extname(file.originalname)}`;
    }

    getHandler() {
        if (this.#fileQuantity > 1) {
            return multer(this.#configurations).array(this.#keyName, this.#fileQuantity);
        }
        return multer(this.#configurations).single(this.#keyName);
    }
}
