import { logger } from '../../../packages/logger';

export class MongooseProvider {
    #count = 3;

    /**
     * @type {string}
     */
    #connectionString;

    /**
     * @type {import('mongoose')}
     */
    #mongooseInstance;

    static builder() {
        return new MongooseProvider();
    }

    setConnectionString(url) {
        this.#connectionString = url;
        return this;
    }

    setMongooseInstance(mongoose) {
        this.#mongooseInstance = mongoose;
        return this;
    }

    async connect() {
        let flag = false;
        try {
            await this.#mongooseInstance
                .connect(this.#connectionString);
            logger.info('Database connected successfully');
            flag = true;
        } catch (error) {
            logger.error(error.message);
            this.#count -= 1;
        }
        setTimeout(() => {
            if (!flag && this.#count) return this.connect();
        }, 3000);
    }
}
