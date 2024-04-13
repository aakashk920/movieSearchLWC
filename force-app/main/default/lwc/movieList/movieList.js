import { LightningElement, api } from 'lwc';

export default class MovieList extends LightningElement {
    @api movies;
    handleView(event) {
        const recordId = event.target.dataset.id;
    console.log('This is the RecordId form the movieList',recordId);
        const viewEvent = new CustomEvent('view', { detail: recordId });
        this.dispatchEvent(viewEvent);
    }
}