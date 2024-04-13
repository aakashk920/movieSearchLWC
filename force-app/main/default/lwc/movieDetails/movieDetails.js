import { LightningElement, api } from 'lwc';

export default class MovieDetails extends LightningElement {
    @api selectedMovie;

    // Handle the view event dispatched from the parent component
    handleView(event) {
        // Extract the recordId from the event detail
        const recordId = event.detail;
        console.log('This is the Movie ID', recordId);

        // You can use the recordId as needed
        // For example, you can fetch movie details using the recordId
    }
}
