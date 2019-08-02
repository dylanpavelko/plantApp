import React from 'react';
import axios from 'axios';
import SearchResultList from './SearchResultList';

export default class Search extends React.Component {
  state = { loading: false, results: [] };

  onChange = (e) => {
    const { value } = e.target;
    this.setState({ loading: true });
    if (value.length > 0) { 
      axios.get('/search.json', { params: { query: value } })
        .then(res => this.setState({ loading: false, results: res.data }))
        .catch(() => this.setState({ loading: false, results: [] }));
    } else {
      this.setState({ loading: false, results: [] });
    }
  }

  submitHandler(e) {
    e.preventDefault();
  }

  render() {
    const { loading, results } = this.state;
    return (
      <div className="ui raised segment no padding">
      { console.log("results" ) }
      { console.log(results.length) }
      { console.log(results) }
        <form method="GET" action="search" onSubmit={this.submitHandler} >
          <div className="ui fluid icon transparent large input">
            <input name="query" type="text" placeholder="Search plants..." onChange={this.onChange} autoComplete="off" />
          </div>
          {results.length > 0 || loading ? <SearchResultList results={results} loading={loading} /> : null}
        </form>
      </div>
    );
  }
}