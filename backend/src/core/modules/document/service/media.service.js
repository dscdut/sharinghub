import { InternalServerException } from 'packages/httpException';
import { cloudinaryUploader } from '../../../config/cloudinary.config';
import { FileSystemService } from './file-system.service';

class Service {
    constructor() {
        this.FileSystemService = FileSystemService;
    }

    async uploadOne(file, folderName = '', public_id = '', overwrite = false) {
        try {
            const response = await cloudinaryUploader.upload(file.path, { folder: folderName, public_id, overwrite });
            return {
                originalName: response.original_filename,
                url: response.secure_url,
                publicId: response.public_id,
            };
        } catch (error) {
            throw new InternalServerException(error.message);
        } finally {
            await FileSystemService.deleteFile(file);
        }
    }

    async uploadMany(files, folderName = '') {
        const uploadTasks = files.map(file => this.uploadOne(file, folderName));

        return Promise.all(uploadTasks);
    }

    async deleteMany(ids) {
        const deleteTasks = ids.map(id => this.deleteOne(id));

        return Promise.all(deleteTasks);
    }

    async deleteOne(id) {
        const response = await cloudinaryUploader.destroy(id);
        return {
            id,
            ...response,
        };
    }
}

export const MediaService = new Service();
