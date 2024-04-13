import { LightningElement, track } from 'lwc';

export default class Movie extends LightningElement {
    @track movies;
    selectedMovie;
    handleSearchResult(event) {
        this.movies = event.detail;
    }
    handleView(event) {
        const selectedMovieId = event.detail;
        this.selectedMovie = this.movies.find(movie => movie.imdbID === selectedMovieId);
    }
}