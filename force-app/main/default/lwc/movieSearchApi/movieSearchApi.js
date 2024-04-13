import { LightningElement, track } from 'lwc';
import getMovies from '@salesforce/apex/MovieSearchController.getMovies';

export default class MovieSearchApi extends LightningElement {
    @track searchTerm = "";
    handleSearchTermChange(event) {
        this.searchTerm = event.target.value;
    }
    searchMovies() {
        getMovies({ searchTerm: this.searchTerm })
            .then(result => {
                console.log('fetching of the data is OK 2', result);
                const searchResultEvent = new CustomEvent('searchresult', { detail: result });
                this.dispatchEvent(searchResultEvent);
            })
            .catch(error => {
                console.error('Error Fetching Movies', error);
            });
    }
}