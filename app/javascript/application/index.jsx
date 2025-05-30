import React, { useEffect, useState } from 'react';
import ReactDOM from 'react-dom/client';
import './styles.css';

const App = () => {
  const [memberId, setMemberId] = useState('');
  const [loading, setLoading] = useState(false);
  const [metrics, setMetrics] = useState(null);
  const [error, setError] = useState(null);

  useEffect(() => {
    if (!memberId) {
      setMetrics(null);
      return;
    }

    setLoading(true);
    setError(null);

    fetch(`/members/${memberId}/metrics`)
      .then((res) => {
        if (!res.ok) throw new Error('Member not found or invalid');
        return res.json();
      })
      .then((data) => setMetrics(data))
      .catch((err) => {
        setMetrics(null);
        setError(err.message);
      })
      .finally(() => setLoading(false));
  }, [memberId]);

  const formatMetricTitle = (label) =>
    label.split('_').map(word => word[0].toUpperCase() + word.slice(1)).join(' ');

  const formatValue = (key, value) => {
    if (value == null) return 'N/A';
    return key === 'average_glucose' ? `${value} mg/dL` : `${value} %`;
  };

  return (
    <div className="container">
      <h1 className="title">📊 Glucose Metrics Dashboard</h1>

      <div className="input-group">
        <label htmlFor="memberId">Enter Member ID:</label>
        <input
          id="memberId"
          type="text"
          value={memberId}
          onChange={(e) => setMemberId(e.target.value)}
          placeholder="e.g. 4"
        />
      </div>

      {loading && <p className="loading">Loading metrics...</p>}
      {error && <p className="error">{error}</p>}

      {metrics && (
        <div className="metrics">
          <h2>📌 Metrics for Member ID: {memberId}</h2>
          {Object.keys(metrics).map((key) => (
            <div key={key} className="metric-card">
              <h3>{formatMetricTitle(key)}</h3>
              <ul>
                <li><strong>Last 7 Days:</strong> {formatValue(key, metrics[key].last_7_days)}</li>
                <li><strong>This Month:</strong> {formatValue(key, metrics[key].this_month)}</li>
                <li><strong>Change from Prior Last 7 Days:</strong> {formatValue(key, metrics[key].delta_7_day)}</li>
                <li><strong>Change from Prior Month:</strong> {formatValue(key, metrics[key].delta_month)}</li>
              </ul>
            </div>
          ))}
        </div>
      )}
    </div>
  );
};

document.addEventListener('DOMContentLoaded', () => {
  const root = ReactDOM.createRoot(document.getElementById('root'));
  root.render(<App />);
});
