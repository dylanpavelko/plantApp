import React from 'react';

export default ({ result }) => (
  <a className="item" href={`/plants/${result.id}`}>
    <div className="middle aligned content">
      <div className="header" dangerouslySetInnerHTML={{__html: result.scientific_name_with_common_names}}></div>
      <div className="meta">{result.author}</div>
    </div>
  </a>
);